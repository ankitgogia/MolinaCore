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

    @discardableResult
    public func request(method: String, url: URL, data: Any?, headers: [String : String?]?, completion: @escaping HTTPUtilityCompletionHandler) -> URLRequest {
        delegate?.httpUtilityActivityDidBegin(self)

        let request = URLRequest(url: url)

        DispatchQueue.global().asyncAfter(seconds: delayDuration) {

            DispatchQueue.main.sync {

                if self.useDefaultResponses {
                    let httpResponse = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)!
                    let data = self.cache[url] ?? Data()
                    completion(httpResponse, data, nil)
                } else {
                    completion(self.httpResponse, self.data, self.error)
                }
                self.delegate?.httpUtilityActivityDidEnd(self)
            }


        }
        return request
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
