
//
//  MolinaCoreExampleTests.swift
//  MolinaCoreExampleTests
//
//  Created by Jaren Hamblin on 4/12/17.
//  Copyright © 2017 HamblinTech. All rights reserved.
//

import XCTest
@testable import MolinaCoreExample
import MolinaCore

class MolinaCoreExampleTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.

        let expect = expectation(description: #function)

        let httpUtility = HTTPUtility(timeoutInterval: 10)

        let url = URL(string: "https://owner-api.teslamotors.com/oauth/token")!

        let headers: [String: String?] = [
            "content-type": "application/json",
            "cache-control": "no-cache"
        ]

        let data: [String: Any] = [
            "grant_type": "password",
            "client_id": "e4a9949fcfa04068f59abb5a658f2bac0a3428e4652315490b659d5ab3f35a9e",
            "client_secret": "c75f14bbadc8bee3a7594412c31416f8300256d7668ea7e6e7f06727bfb9d220",
            "email": "jjjjaren@gmail.com",
            "password": "117Dajaman182"
        ]

        httpUtility.post(url, data: data, headers: headers) { (httpResponse, data, error) in
            expect.fulfill()

            guard httpResponse.statusCode == 200 else {
                XCTFail()
                return
            }

            guard let data = data else {
                XCTFail()
                return
            }

            guard let json = try? JSONSerialization.jsonObject(with: data) else {
                XCTFail()
                return
            }

            log.debug(json)

        }

        waitForExpectations(timeout: 10) { error in
            if let error = error {
                XCTFail(error.localizedDescription)
            }
        }
    }

}
