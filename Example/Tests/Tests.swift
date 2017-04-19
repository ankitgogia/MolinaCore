import UIKit
import XCTest
import MolinaCore

class Tests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testStringValidatorEmailAddressFormat() {
        // This is an example of a functional test case.
        
        
        XCTAssertFalse("".isValidEmailAddress)
        XCTAssertFalse("jjjjaren".isValidEmailAddress)
        XCTAssertFalse("jjjjaren@".isValidEmailAddress)
        XCTAssertFalse("jjjjaren@gmail".isValidEmailAddress)
        XCTAssertFalse("jjjjaren@gmail.".isValidEmailAddress)
        XCTAssertTrue("jjjjaren@gmail.com".isValidEmailAddress)
        
    }
    
    func testStringValidatorFiveDigitZipCodeFormat() {
        // This is an example of a functional test case.
        
        
        XCTAssertFalse("".isValidZipCode5)
        XCTAssertFalse("1".isValidZipCode5)
        XCTAssertFalse("12".isValidZipCode5)
        XCTAssertFalse("123".isValidZipCode5)
        XCTAssertFalse("1234".isValidZipCode5)
        XCTAssertTrue("12345".isValidZipCode5)
        XCTAssertFalse("123456".isValidZipCode5)
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure() {
            // Put the code you want to measure the time of here.
        }
    }
    
}
