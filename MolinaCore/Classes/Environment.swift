//
//  Environment.swift
//  MemberHIH
//
//  Created by Jaren Hamblin on 11/2/16.
//  Copyright © 2016 Molina Healthcare Inc. All rights reserved.
//

import Foundation

public enum Environment: String {
    // WARNING: The values correspond to Xcode user defined configuration setting name - DO NOT CHANGE
    case mock = "mock"
    case dev = "dev"
    case test = "test"
    case staging = "staging"
    case appStore = "appstore" // Production
    case performance = "performance"
    
    
    
    
    
    private static let bundle: Bundle = Bundle.main
    
    public static func getValue(key: String) -> String {
        let value = Environment.bundle.object(forInfoDictionaryKey: key) as? String
        return value ?? ""
    }
    
    
    
    
    
    /// Returns the environment configuration name
    public static let configurationName: String = {
        let environmentName = (Environment.bundle.object(forInfoDictionaryKey: "Configuration") as! String)
        return environmentName
    }()
    
    /// Returns the current environment as per the build settings information (defaults to Release if invalid configs)
    public static let current: Environment = {
        let environmentName = configurationName.lowercased()
        let environment = Environment(rawValue: environmentName) ?? Environment.appStore
        return environment
    }()
    
    /// Returns the current bundle identifier
    public static let bundleIdentifier: String = { return Environment.bundle.bundleIdentifier! as String }()
    
    /// Namespace
    public static let namespace: String = { return Environment.getValue(key: "Namespace") }()
    
    /// Base URL String
    public static let baseUrlString: String = { return Environment.getValue(key: "APIBaseURL") }()
    
    /// Base URL
    public static let baseUrl: URL = { return URL(string: Environment.baseUrlString)! }()
    
    
    
    
    
    
    // MARK: - App Version/Build
    
    /// Returns the version
    public static let version: String = { return bundle.infoDictionary?["CFBundleShortVersionString"] as? String ?? "Unknown" }()
    
    /// Returns the build number
    public static let build: String = { return bundle.infoDictionary?["CFBundleVersion"] as? String ?? "Unknown" }()
    
    
}





// MARK: - Device Related

extension Environment {
    
    
    /// Returns whether the current Environment is running in a simulator
    public static let isSimulator: Bool = {
        #if (arch(i386) || arch(x86_64)) && os(iOS)
            return true
        #else
            return false
        #endif
    }()
}






// MARK: - File Management Related

extension Environment {

    // MARK: - File Management
    // TODO: Refactor into its own file, perhaps as an enum
    public struct Directory {
        private static func directoryURL(for searchDirectory: FileManager.SearchPathDirectory) -> URL {
            let urls = FileManager.default.urls(for: searchDirectory, in: FileManager.SearchPathDomainMask.userDomainMask)
            return urls[urls.count-1]
        }
        
        public static var document: URL = { return directoryURL(for: FileManager.SearchPathDirectory.documentDirectory) }()
        public static var library: URL = { return directoryURL(for: FileManager.SearchPathDirectory.libraryDirectory) }()
        public static var applicationSupport: URL = { return directoryURL(for: FileManager.SearchPathDirectory.applicationSupportDirectory) }()
    }
}
