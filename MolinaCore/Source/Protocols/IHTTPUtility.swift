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
    func defaultHeaders() -> [String: String?]
}

extension IHTTPUtilityDelegate {
    func httpUtilityActivityDidBegin(_ httpUtility: IHTTPUtility) {}
    func httpUtilityActivityDidEnd(_ httpUtility: IHTTPUtility) {}
    func httpUtilityRequestDidComplete(_ httpUtility: IHTTPUtility, withStatus statusCode: Int) {}
    func defaultHeaders() -> [String: String?] { return [:] }
}

public protocol IHTTPUtility: class {
    var delegate: IHTTPUtilityDelegate? { get set }

    @discardableResult
    func request(method: String, url: URL, data: Any?, headers: [String: String?]?, completion: @escaping HTTPUtilityCompletionHandler) -> URLRequest

    func clearSession(completion: @escaping () -> Void)
}

extension IHTTPUtility {

    @discardableResult
    public func get(_ url: URL, data: Any? = nil, headers: [String :String?]? = nil, completion: @escaping HTTPUtilityCompletionHandler) -> URLRequest {
        return request(method: "get", url: url, data: data, headers: headers, completion: completion)
    }

    @discardableResult
    public func post(_ url: URL, data: Any? = nil, headers: [String :String?]? = nil, completion: @escaping HTTPUtilityCompletionHandler) -> URLRequest {
        return request(method: "post", url: url, data: data, headers: headers, completion: completion)
    }

    @discardableResult
    public func put(_ url: URL, data: Any? = nil, headers: [String :String?]? = nil, completion: @escaping HTTPUtilityCompletionHandler) -> URLRequest {
        return request(method: "put", url: url, data: data, headers: headers, completion: completion)
    }

    @discardableResult
    public func delete(_ url: URL, data: Any? = nil, headers: [String :String?]? = nil, completion: @escaping HTTPUtilityCompletionHandler) -> URLRequest {
        return request(method: "delete", url: url, data: data, headers: headers, completion: completion)
    }
    
    public func clearSession(completion: @escaping () -> Void) {
        completion()
    }
}
