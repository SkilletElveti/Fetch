//
//  GeneralisedRequest.swift
//  Fetch Takeaway
//
//  Created by Shubham Kamdi on 9/9/23.
//

import Foundation

extension Request {
    private func getComponenets(for constant: Constants) -> URLComponents {
        var components = URLComponents()
        components.scheme = Constants.apiScheme.rawValue
        components.host = Constants.apiHost.rawValue
        components.path = Constants.apiPath.rawValue + constant.rawValue
        return components
    }
    
    private func append(
        component query: String,
        with value: String,
        for constant: Constants
    ) -> URLComponents {
        var components = getComponenets(for: constant)
        components.queryItems = [URLQueryItem(name: query, value: value)]
        return components
    }
    
    private func meal(list identifier: String = "Desert") -> URL? {
        let components = append(
            component: "c",
            with: identifier,
            for: .apiFilterIdentifier
        )
        GeneralisedLogger.log(message: "Meal_List Endpoint => \(components.url?.absoluteString ?? "Unknown")")
        return components.url
    }
    
    private func meal(details forId: String) -> URL? {
        let components = append(
            component: "i",
            with: forId,
            for: .apiLookupIdentifier
        )
        GeneralisedLogger.log(message: "Meal_List Endpoint => \(components.url?.absoluteString ?? "UNKNOWN")")
        return components.url
    }
    
}
/// Server endpoint representation
/// - Parameter `meals`: Get meal list takes meal name as parameter
/// - Parameter `details`: Get meal details for a particular meal id
///
enum Request {
    case meals(String)
    case details(String)
    func getEndpoint() ->  URL? {
        switch self {
        case .meals(let dish):
            return meal(list: dish)
        case .details(let mealId):
            return meal(details: mealId)
        }
    }
}
