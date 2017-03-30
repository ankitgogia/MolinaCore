//
//  ILogUtility,swift
//  ResearchKit-Demo-1
//
//  Created by Jaren Hamblin on 8/16/16.
//  Copyright © 2016 Jaren Hamblin. All rights reserved.
//

import Foundation

public protocol LogUtilityDelegate: class {
    func shouldLog(level: LogLevel) -> Bool
    func didLog(level: LogLevel, message: String, file: String, line: Int, column: Int, function: String, date: Date)
}

extension LogUtilityDelegate {
    func shouldLog(level: LogLevel) -> Bool { return true }
}

public enum LogLevel: String {
    case verbose = "Verbose"
    case debug = "Debug"
    case info = "Info"
    case warning = "Warning"
    case error = "Error"
    case severe = "Severe"
    case system = "System"
    case service = "Service"
}

public protocol ILogUtility: class {
    func log(_ level: LogLevel, message: [Any?], file: String, line: Int, column: Int, function: String)
    var delegate: LogUtilityDelegate? { get set }
}

extension ILogUtility {
    public func verbose(_ message: Any?..., file: String = #file, line: Int = #line, column: Int = #column, function: String = #function) {
        log(LogLevel.verbose, message: message, file: file, line: line, column: column, function: function)
    }

    public func debug(_ message: Any?..., file: String = #file, line: Int = #line, column: Int = #column, function: String = #function) {
        log(LogLevel.debug, message: message, file: file, line: line, column: column, function: function)
    }

    public func info(_ message: Any?..., file: String = #file, line: Int = #line, column: Int = #column, function: String = #function) {
        log(LogLevel.info, message: message, file: file, line: line, column: column, function: function)
    }

    public func warning(_ message: Any?..., file: String = #file, line: Int = #line, column: Int = #column, function: String = #function) {
        log(LogLevel.warning, message: message, file: file, line: line, column: column, function: function)
    }

    public func error(_ message: Any?..., file: String = #file, line: Int = #line, column: Int = #column, function: String = #function) {
        log(LogLevel.error, message: message, file: file, line: line, column: column, function: function)
    }

    public func severe(_ message: Any?..., file: String = #file, line: Int = #line, column: Int = #column, function: String = #function) {
        log(LogLevel.severe, message: message, file: file, line: line, column: column, function: function)
    }

    public func system(_ message: Any?..., file: String = #file, line: Int = #line, column: Int = #column, function: String = #function) {
        log(LogLevel.system, message: message, file: file, line: line, column: column, function: function)
    }

    public func service(_ message: Any?..., file: String = #file, line: Int = #line, column: Int = #column, function: String = #function) {
        log(LogLevel.service, message: message, file: file, line: line, column: column, function: function)
    }
}
