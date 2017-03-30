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

    public var session: URLSession

    public init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    fileprivate func addHeaders(to request: URLRequest, headers: [String: String?]?) -> URLRequest {
        var request = request
        if let headers = headers {
            for (key, value) in headers {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        return request
    }
    
    fileprivate func addData(to request: URLRequest, data: Any?) -> URLRequest {
        var request = request
        if let parameters = data as? [String: Any] {
            request.httpBody = Data(JSONObject: parameters as AnyObject)
        }
        return request
    }

    fileprivate func requestHandler(request: URLRequest, completionHandler: @escaping HTTPUtilityCompletionHandler) -> URLRequest {
        delegate?.httpUtilityActivityDidBegin(self)
        let task = session.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                self.delegate?.httpUtilityActivityDidEnd(self)
                let httpResponse = response as? HTTPURLResponse ?? HTTPURLResponse()
                completionHandler(httpResponse, data, error)
            }
        }
        task.resume()
        return request
    }

    open func post(_ url: URL, data: Any?, headers: [String: String?]?, completionHandler: @escaping HTTPUtilityCompletionHandler) -> URLRequest {
        // Create the url and the request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request = addHeaders(to: request, headers: headers)
        request = addData(to: request, data: data)
        return requestHandler(request: request, completionHandler: completionHandler)
    }

    open func put(_ url: URL, data: Any?, headers: [String: String?]?, completionHandler: @escaping HTTPUtilityCompletionHandler) -> URLRequest {
        // Create the url and the request
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request = addHeaders(to: request, headers: headers)
        request = addData(to: request, data: data)
        return requestHandler(request: request, completionHandler: completionHandler)
    }

    open func get(_ url: URL, data: Any?, headers: [String:String?]?, completionHandler: @escaping HTTPUtilityCompletionHandler) -> URLRequest {
        // Create the url and request
        var request = URLRequest(url: url)
        request = addHeaders(to: request, headers: headers)
        request = addData(to: request, data: data)
        return requestHandler(request: request, completionHandler: completionHandler)
    }

    open func delete(_ url: URL, data: Any?, headers: [String:String?]?, completionHandler: @escaping HTTPUtilityCompletionHandler) -> URLRequest {

        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request = addHeaders(to: request, headers: headers)
        request = addData(to: request, data: data)
        return requestHandler(request: request, completionHandler: completionHandler)
    }

    // MARK: - URLSessionDelegate

    public func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        completionHandler(.useCredential, URLCredential(trust: challenge.protectionSpace.serverTrust!))
    }
}
