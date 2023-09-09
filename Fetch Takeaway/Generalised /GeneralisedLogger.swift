//
//  GeneralisedLogger.swift
//  Fetch Takeaway
//
//  Created by Shubham Kamdi on 9/9/23.
//

import Foundation
import OSLog
/// Generalised Logging class. Abstarction to print OS logs. Beneficial to debug apps at console level
class GeneralisedLogger {
    /// Use for debug level logs
    static func log(
        debug message: String,
        filter log: String = Constants.filterDebug.rawValue
    ) {
        Logger.statistics.debug("[\(log)]: \(message)")
    }
    
    /// Use for error level logs
    static func log(
        error message: String,
        filter log: String = Constants.filterError.rawValue
    ) {
        Logger.error.error("[\(log)]: \(message)")
    }
    
    /// Use for generalised messages
    static func log(
        message: String,
        filter log: String = Constants.filterMessage.rawValue
    ) {
        Logger.message.log("[\(log)]: \(message)")
    }
}

extension Logger {
    /// Using your bundle identifier is a great way to ensure a unique identifier.
    private static var subsystem = Bundle.main.bundleIdentifier!

    /// Logs the view cycles like a view that appeared.
    static let viewCycle = Logger(subsystem: subsystem, category: "viewcycle")

    /// All logs related to tracking and analytics.
    static let statistics = Logger(subsystem: subsystem, category: "Debug")
    
    /// All logs related to error.
    static let error = Logger(subsystem: subsystem, category: "Error")
    
    /// All logs related to messages.
    static let message = Logger(subsystem: subsystem, category: "Message")
}
