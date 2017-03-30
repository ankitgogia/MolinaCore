//
//  LogUtility.swift
//  ResearchKit-Demo-1
//
//  Created by Jaren Hamblin on 8/16/16.
//  Copyright © 2016 Jaren Hamblin. All rights reserved.
//

import Foundation

open class LogUtility: ILogUtility {
    public weak var delegate: LogUtilityDelegate?
    public static let shared: ILogUtility = LogUtility()
    public static let defaultDateFormat = "yyyy-MM-dd HH:mm:ss.SSS"

    fileprivate let useBackgroundThread: Bool = true
    fileprivate let dateFormatter = DateFormatter()

    public init(dateFormat: String = LogUtility.defaultDateFormat) {
        dateFormatter.dateFormat = dateFormat
    }

    // MARK: - Private Interface

    open func log(_ level: LogLevel, message: [Any?], file: String, line: Int, column: Int, function: String) {
        
        let shouldLog = delegate?.shouldLog(level: level) ?? true
        guard shouldLog else { return }

        let thread = Thread.isMainThread ? "Main" : "Background"
        let queue = useBackgroundThread ? DispatchQueue.global(qos: DispatchQoS.QoSClass.userInitiated) : DispatchQueue.main

        queue.sync {
            
            let date = Date()
            let dateString = self.dateFormatter.string(from: date)

            var components = [String]()
            components.append("\(dateString)")
            components.append("[\(level.rawValue)]")
            components.append("[\(thread)]")
            
            let fileName = file.components(separatedBy: "/").last ?? ""
            components.append("[\(fileName):\(line)] \(function)")

            let logDetails = components.joined(separator: " ")
            let logMessage = message.flatMap{$0}.map { "\($0)" }.joined(separator: " ")
            
            
            delegate?.didLog(level: level, message: logMessage, file: fileName, line: line, column: column, function: function, date: date)

            // Write to console
            if type(of: logMessage) != NSNull.self {
                let finalLog = logDetails + " > " + logMessage
                print(finalLog)
            }
        }
    }
}

public let log: ILogUtility = LogUtility.shared
