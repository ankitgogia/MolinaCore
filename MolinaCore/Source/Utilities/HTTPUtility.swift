//
//  HTTPUtility.swift
//  ResearchKit-Demo-1
//
//  Created by Jaren Hamblin on 8/16/16.
//  Copyright © 2016 Jaren Hamblin. All rights reserved.
//

import Foundation

open class HTTPUtility: IHTTPUtility {

    open static let defaultInstance = HTTPUtility()

    open var delegate: IHTTPUtilityDelegate? = nil

    public let timeoutInterval: TimeInterval
    public var session: URLSession

    public init(session: URLSession = URLSession.shared, timeoutInterval: TimeInterval = 60.0) {
        self.session = session
        self.timeoutInterval = timeoutInterval
    }

    @discardableResult
    fileprivate func requestHandler(url: URL, method: String, data: Any?, headers: [String: String?]?, completionHandler: @escaping HTTPUtilityCompletionHandler) -> URLRequest {
        delegate?.httpUtilityActivityDidBegin(self)

        var request = URLRequest(url: url, cachePolicy: URLRequest.CachePolicy.useProtocolCachePolicy, timeoutInterval: self.timeoutInterval)
        request.httpMethod = method

        if let headers = headers {
            for (key, value) in headers {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }

        if let parameters = data as? [String: Any] {
            request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
        }

        log.debug(url, JSON(headers as Any), JSON(data as Any))

        let task = self.session.dataTask(with: request) { data, response, error in

            self.delegate?.httpUtilityActivityDidEnd(self)
            let httpResponse = response as? HTTPURLResponse ?? HTTPURLResponse()

            let responseJson: Any? = {
                if let data = data {
                    return try? JSONSerialization.jsonObject(with: data)
                }
                return nil
            }()

            log.debug(url, JSON(headers as Any), JSON(data as Any), httpResponse.statusCode, JSON(responseJson as Any), error?.localizedDescription)

            completionHandler(httpResponse, data, error)

        }
        
        task.resume()
        return request
    }

    @discardableResult
    open func post(_ url: URL, data: Any?, headers: [String: String?]?, completionHandler: @escaping HTTPUtilityCompletionHandler) -> URLRequest {
        return requestHandler(url: url, method: "POST", data: data, headers: headers, completionHandler: completionHandler)
    }

    @discardableResult
    open func put(_ url: URL, data: Any?, headers: [String: String?]?, completionHandler: @escaping HTTPUtilityCompletionHandler) -> URLRequest {
        return requestHandler(url: url, method: "PUT", data: data, headers: headers, completionHandler: completionHandler)
    }

    @discardableResult
    open func get(_ url: URL, data: Any?, headers: [String:String?]?, completionHandler: @escaping HTTPUtilityCompletionHandler) -> URLRequest {
        return requestHandler(url: url, method: "GET", data: data, headers: headers, completionHandler: completionHandler)
    }

    @discardableResult
    open func delete(_ url: URL, data: Any?, headers: [String:String?]?, completionHandler: @escaping HTTPUtilityCompletionHandler) -> URLRequest {
        return requestHandler(url: url, method: "DELETE", data: data, headers: headers, completionHandler: completionHandler)
    }

    // MARK: - URLSessionDelegate

    public func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        completionHandler(.useCredential, URLCredential(trust: challenge.protectionSpace.serverTrust!))
    }
}
