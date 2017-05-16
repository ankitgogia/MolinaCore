//
//  AlamofireUtility.swift
//  MemberHIH
//
//  Created by Jaren Hamblin on 11/2/16.
//  Copyright © 2016 Molina Healthcare Inc. All rights reserved.
//

import Foundation
import Alamofire

open class AlamofireUtility: Alamofire.SessionDelegate, IHTTPUtility {

    @discardableResult
    public func request(method: String, url: URL, data: Any?, headers: [String : String?]?, completion: @escaping HTTPUtilityCompletionHandler) -> URLRequest {

        let method = HTTPMethod(rawValue: method.uppercased()) ?? .get

        let parameterEncoding: HTTPUtilityParameterEncoding? = HTTPUtilityParameterEncoding.json

        delegate?.httpUtilityActivityDidBegin(self)

        let parameters: Parameters? = data as? Parameters

        var httpHeaders: HTTPHeaders = [:]
        delegate?.defaultHeaders().forEach { (key, value) in httpHeaders[key] = value }
        headers?.forEach { (key, value) in httpHeaders[key] = value }

        var alamofireParameterEncoding: ParameterEncoding = JSONEncoding.default
        if method == HTTPMethod.get {
            alamofireParameterEncoding = URLEncoding.default
        } else if let parameterEncoding = parameterEncoding {
            alamofireParameterEncoding = parameterEncoding == HTTPUtilityParameterEncoding.url ? URLEncoding.queryString : JSONEncoding.default
        }

        log.debug(method, parameterEncoding, url, data)

        let request = sessionManager.request(url, method: method, parameters: parameters, encoding: alamofireParameterEncoding, headers: httpHeaders)
            .responseJSON { response in

                self.delegate?.httpUtilityActivityDidEnd(self)
                let httpResponse = response.response ?? HTTPURLResponse()

                self.logResponseDetails(url: url, method: method, data: data, headers: headers, response: response)

                completion(httpResponse, response.data, response.result.error)
                self.delegate?.httpUtilityRequestDidComplete(self, withStatus: httpResponse.statusCode)


        }

        var urlRequest: URLRequest! = request.request
        if urlRequest == nil {
            urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = method.rawValue
        }
        return urlRequest
    }

    
    fileprivate let configuration: URLSessionConfiguration
    fileprivate let serverTrustPolicyManager: ServerTrustPolicyManager?
    fileprivate let log: ILogUtility
    open var delegate: IHTTPUtilityDelegate? = nil
    
    fileprivate lazy var sessionManager: Alamofire.SessionManager! = {
        return Alamofire.SessionManager(configuration: self.configuration, delegate: self, serverTrustPolicyManager: self.serverTrustPolicyManager)
    }()
    
    public init(timeoutIntervalForRequest: TimeInterval = 30, serverTrustPolicies: [String: ServerTrustPolicy]? = nil, logger: ILogUtility = LogUtility.shared) {
        
        self.log = logger
        
        // Session Configuration
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        configuration.timeoutIntervalForRequest = timeoutIntervalForRequest // seconds
        self.configuration = configuration
        
        // Server Trust Policies
        if let serverTrustPolicies = serverTrustPolicies {
            self.serverTrustPolicyManager = ServerTrustPolicyManager(policies: serverTrustPolicies)
        } else {
            self.serverTrustPolicyManager = nil
        }
        
        super.init()
        
        self.sessionDidReceiveChallengeWithCompletion = { (urlSession, challenge, completion) in
            completion(.useCredential, URLCredential(trust: challenge.protectionSpace.serverTrust!))
        }
    }
    
    open func clearSession(completion: @escaping () -> Void) {
        let session = sessionManager.session
        log.debug("Invaliding session and cancelling tasks...")
        session.invalidateAndCancel()
        session.reset {
            self.log.debug("Resetting session...")
            self.sessionManager = nil
            completion()
        }
    }
    
    
    /// Logging
    fileprivate func logResponseDetails(url: URL, method: HTTPMethod, data: Any?, headers: [String: String?]?, response: DataResponse<Any>?) {
        let httpResponse = response?.response ?? HTTPURLResponse()
        let statusCode = httpResponse.statusCode
        let httpUrlResponseError = HTTPURLResponse.localizedString(forStatusCode: statusCode).capitalized
        
        let headers = headers ?? [:]
        let headersJson = JSON(headers)
        
        var components: [String] = []
        
        components.append("URL: \(url.absoluteString)")
        components.append("Method: \(method.rawValue)")
        components.append("Headers:\n\(headersJson)")
        if let parameters = data as? Parameters {
            let parametersJson = JSON(parameters)
            components.append("RequestBody:\n\(parametersJson)")
        }
        components.append("ResponseStatusCode: \(statusCode)")
        components.append("ResponseStatusMessage: \(httpUrlResponseError)")
        if let data = response?.data {
            let responseJson = JSON(data: data)
            components.append("ResponseBody:\n\(responseJson)")
        }
        if let errorLocalizedDescription = response?.result.error?.localizedDescription {
            components.append("Error: \(errorLocalizedDescription)")
        }
        
        let logMessage = components.joined(separator: "\n")
        
        if statusCode != 200 {
            self.log.error(logMessage)
        } else {
            self.log.debug(logMessage)
        }
    }
}
