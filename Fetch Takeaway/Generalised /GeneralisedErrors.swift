//
//  GeneralisedErrors.swift
//  Fetch Takeaway
//
//  Created by Shubham Kamdi on 9/9/23.
//

import Foundation
enum GeneralisedError: Error {
    // Throw when an invalid password is entered
    case noNetworkConnectivity

    // Throw when an expected resource is not found
    case notFound

    // Throw in all other cases
    case unexpected(code: Int)
}

extension GeneralisedError: CustomStringConvertible {
    public var description: String {
        switch self {
        case .noNetworkConnectivity:
            return "Network not available. Can you check your connectivity to Cellur or Wifi Network."
        case .notFound:
            return "The specified item could not be found."
        case .unexpected(_):
            return "An unexpected error occurred."
        }
    }
}

extension GeneralisedError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .noNetworkConnectivity:
            return NSLocalizedString(
                "Network not available. Can you check your connectivity to Cellur or Wifi Network.",
                comment: "Internet not available"
            )
        case .notFound:
            return NSLocalizedString(
                "The specified item could not be found.",
                comment: "Resource Not Found"
            )
        case .unexpected(_):
            return NSLocalizedString(
                "An unexpected error occurred.",
                comment: "Unexpected Error"
            )
        }
    }
}
