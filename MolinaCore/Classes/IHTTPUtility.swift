//
//  HTTPUtilityProtocol.swift
//  ResearchKit-Demo-1
//
//  Created by Jaren Hamblin on 8/16/16.
//  Copyright © 2016 Jaren Hamblin. All rights reserved.
//

import Foundation

public typealias HTTPUtilityCompletionHandler = (_ httpResponse: HTTPURLResponse, _ data: Data?, _ error: Error?) -> Void

public protocol IHTTPUtilityDelegate: class {
    func httpUtilityActivityDidBegin(_ httpUtility: IHTTPUtility)
    func httpUtilityActivityDidEnd(_ httpUtility: IHTTPUtility)
    func httpUtilityRequestDidComplete(_ httpUtility: IHTTPUtility, withStatus statusCode: Int)
}

extension IHTTPUtilityDelegate {
    func httpUtilityActivityDidBegin(_ httpUtility: IHTTPUtility) {}
    func httpUtilityActivityDidEnd(_ httpUtility: IHTTPUtility) {}
    func httpUtilityRequestDidComplete(_ httpUtility: IHTTPUtility, withStatus statusCode: Int) {}
}

public protocol IHTTPUtility: class {
    var delegate: IHTTPUtilityDelegate? { get set }

    /**
     HTTP GET - Retrieves data from a web service
     - parameter url: NSURL - The location of the web service
     - parameter accessToken: String? - The authentication accessToken that validates the user is logged in
     - parameter completionHandler: (statusCode: Int, data: NSData?, error: NSError?)
     */

    @discardableResult
    func get(_ url: URL, data: Any?, headers: [String :String?]?, completionHandler: @escaping HTTPUtilityCompletionHandler) -> URLRequest

    /**
     HTTP POST - Sends data to a web service
     - parameter url: NSURL - The location of the web service
     - parameter data: [String:Any]? - The data we want to send
     - parameter accessToken: String? - The authentication accessToken that validates the user is logged in
     - parameter completionHandler: (statusCode: Int, data: NSData?, error: NSError?)
     */
    
    @discardableResult
    func post(_ url: URL, data: Any?, headers: [String :String?]?, completionHandler: @escaping HTTPUtilityCompletionHandler) -> URLRequest

    /**
     HTTP PUT - Sends data to a web service
     - parameter url: NSURL - The location of the web service
     - parameter data: [String:Any]? - The data we want to send
     - parameter accessToken: String? - The authentication accessToken that validates the user is logged in
     - parameter completionHandler: (statusCode: Int, data: NSData?, error: NSError?)
     */
    
    @discardableResult
    func put(_ url: URL, data: Any?, headers: [String :String?]?, completionHandler: @escaping HTTPUtilityCompletionHandler) -> URLRequest
    
    @discardableResult
    func delete(_ url: URL, data: Any?, headers: [String :String?]?, completionHandler: @escaping HTTPUtilityCompletionHandler) -> URLRequest
    
    func clearSession(completion: @escaping () -> Void)
}

extension IHTTPUtility {

    public func get(_ url: URL, data: Any? = nil, headers: [String :String?]? = nil, completionHandler: @escaping HTTPUtilityCompletionHandler) -> URLRequest {
        return get(url, data: data, headers: headers, completionHandler: completionHandler)
    }

    public func post(_ url: URL, data: Any? = nil, headers: [String :String?]? = nil, completionHandler: @escaping HTTPUtilityCompletionHandler) -> URLRequest {
        return post(url, data: data, headers: headers, completionHandler: completionHandler)
    }

    public func put(_ url: URL, data: Any? = nil, headers: [String :String?]? = nil, completionHandler: @escaping HTTPUtilityCompletionHandler) -> URLRequest {
        return put(url, data: data, headers: headers, completionHandler: completionHandler)
    }

    public func delete(_ url: URL, data: Any? = nil, headers: [String :String?]? = nil, completionHandler: @escaping HTTPUtilityCompletionHandler) -> URLRequest {
        return delete(url, data: data, headers: headers, completionHandler: completionHandler)
    }
    
    public func clearSession(completion: @escaping () -> Void) {
        completion()
    }
}
