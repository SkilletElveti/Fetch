//
//  HttpApiService.swift
//  Fetch Takeaway
//
//  Created by Shubham Kamdi on 9/9/23.
//

import Foundation
import Combine
import Reachability
import OSLog
/// Network Layer
/// Responsible to perform networking requests, has a built in reachibility component which manages no network scenarios.
/// - Note : This Layer does not perform Auth or Token Management.
/// - Parameter `networkPublisher`: Observe this to inform the view layer that network is not available, set value implies no network is available.
class HttpApiService: ObservableObject {
    static let shared = HttpApiService()
    private var reachibilityObserver: Reachability?
    private var isNetworkAvailable: Bool = true
    
    var networkPublisher: CurrentValueSubject<Bool,Never> = .init(false)
    private init() {
        do {
            try initializeReachibility()
        } catch {
            guard let error = error as? GeneralisedError else { return }
            manageError(error: error)
        }
    }
}

// MARK: - Reachibility
/// Network connectivity abstarction, coupled with network layer. Will be called once in the init block of HttpApiService class
extension HttpApiService {
    private func initializeReachibility() throws {
        self.reachibilityObserver = try Reachability()
        guard let reachibilityObserver else { throw GeneralisedError.notFound }
        reachibilityObserver.whenUnreachable = { [weak self] _ in
            guard let self else { return }
            self.networkPublisher.send(false)
        }
        reachibilityObserver.whenUnreachable = { [weak self] _ in
            guard let self else { return }
            self.networkPublisher.send(true)
        }
    }
}

// MARK: - Error Management
/// Manage errors related to network layer
private extension HttpApiService {
    func manageError(
        error: GeneralisedError
    ) {
        switch error {
        case .noNetworkConnectivity:
            self.isNetworkAvailable = false
            GeneralisedLogger.log(
                error: error.localizedDescription
            )
        case .notFound:
            GeneralisedLogger.log(
                error: error.localizedDescription
            )
        case .unexpected(let code):
            GeneralisedLogger.log(
                error: error.localizedDescription
            )
        }
    }
}

// MARK: - HTTP Transactions
/// Perform HTTP Requests, methods are exposed to All the layers of the app. Scope of the app is limited to performing `GET` requests.
extension HttpApiService {
    /// Perform `GET` requests
    /// - Parameter `get`: Endpoint to which you want request
    func perform<M: Decodable>(
        get request: Request
    ) async throws -> M {
        guard let url = request.getEndpoint() else { throw GeneralisedError.notFound }
        let result: M = try await consume(request: createRequest(for: url, httpMethod: "GET"))
        return result
    }
    
    /// Will create a url request for consumtion
    private func createRequest(
        for url: URL,
        httpMethod type: String
    ) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = type
        return request
    }
    
    /// Consuming the URLRequest with generalised return type
    private func consume<M: Decodable>(request: URLRequest) async throws -> M {
        guard self.isNetworkAvailable else { throw GeneralisedError.noNetworkConnectivity }
        async let (data,urlResponse) = try await URLSession.shared.data(for: request)
        guard let response = try await urlResponse as? HTTPURLResponse else {
            throw GeneralisedError.unexpected(code: 1)
        }
        GeneralisedLogger.log(message: "Response: \(response)")
        if response.statusCode == 200 {
            // Parse response
            return try await JSONDecoder().decode(M.self, from: data) 
        }
        throw GeneralisedError.unexpected(code: 0)
    }
}

