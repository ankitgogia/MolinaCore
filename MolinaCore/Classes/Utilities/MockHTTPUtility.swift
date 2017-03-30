//
//  MockHTTPUtility.swift
//  ResearchKit-Demo-1
//
//  Created by Jaren Hamblin on 8/18/16.
//  Copyright © 2016 Jaren Hamblin. All rights reserved.
//
import Foundation

open class MockHTTPUtility: IHTTPUtility {

    fileprivate var httpResponse: HTTPURLResponse = {
        guard let url = URL(string: "https://molina-xctest.com/") else {
            fatalError("Failed to gen temp url for MockHTTPUtility")
        }
        guard let httpResponse = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil) else {
            fatalError("Failed to gen temp http url response for MockHTTPUtility")
        }
        return httpResponse
    }()
    fileprivate var data: Data?
    fileprivate var error: Error?
    fileprivate var cache: [URL: Data?] = [:]
    open static let defaultInstance = MockHTTPUtility()
    open let delayDuration: Double
    open let useDefaultResponses: Bool
    open var delegate: IHTTPUtilityDelegate? = nil
    

    public init(delayDuration: Double = 0, useDefaultResponses: Bool = false) {
        self.delayDuration = delayDuration
        self.useDefaultResponses = useDefaultResponses
    }
    
    
    
    
    // MARK: - Helpers

    private func sendMockRequest(_ url: URL, data: Any?, headers: [String : String?]?, completionHandler: @escaping HTTPUtilityCompletionHandler) -> URLRequest {
        delegate?.httpUtilityActivityDidBegin(self)
        
        let request = URLRequest(url: url)
        
        DispatchQueue.global().asyncAfter(seconds: delayDuration) { 
            
            if self.useDefaultResponses {
                let httpResponse = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)!
                let data = self.cache[url] ?? Data()
                completionHandler(httpResponse, data, nil)
            } else {
                completionHandler(self.httpResponse, self.data, self.error)
            }
            self.delegate?.httpUtilityActivityDidEnd(self)
        }
        return request
    }
    
    
    
    // MARK: - IHTTPUtility
    
    public func get(_ url: URL, data: Any?, headers: [String : String?]?, completionHandler: @escaping HTTPUtilityCompletionHandler) -> URLRequest {
        return sendMockRequest(url, data: data, headers: headers, completionHandler: completionHandler)
    }

    public func put(_ url: URL, data: Any?, headers: [String : String?]?, completionHandler: @escaping HTTPUtilityCompletionHandler) -> URLRequest {
        return sendMockRequest(url, data: data, headers: headers, completionHandler: completionHandler)
    }
    
    public func post(_ url: URL, data: Any?, headers: [String : String?]?, completionHandler: @escaping HTTPUtilityCompletionHandler) -> URLRequest {
        return sendMockRequest(url, data: data, headers: headers, completionHandler: completionHandler)
    }
    
    public func delete(_ url: URL, data: Any?, headers: [String : String?]?, completionHandler: @escaping HTTPUtilityCompletionHandler) -> URLRequest {
        return sendMockRequest(url, data: data, headers: headers, completionHandler: completionHandler)
    }
    
    
    // MARK: - Additional Public Interface

    public func set(httpResponse: HTTPURLResponse) {
        self.httpResponse = httpResponse
    }

    public func set(data: Data?) {
        self.data = data
    }

    public func set(error: Error?) {
        self.error = error
    }
    
    
    
    // MARK: - Mock Data Helpers
    
    public func register(url: URL, data: Data?) {
        cache[url] = data
    }
}
