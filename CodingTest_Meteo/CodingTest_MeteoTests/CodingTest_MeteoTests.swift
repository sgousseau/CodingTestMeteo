//
//  CodingTest_MeteoTests.swift
//  CodingTest_MeteoTests
//
//  Created by Sébastien Gousseau on 16/06/2019.
//  Copyright © 2019 Sébastien Gousseau. All rights reserved.
//

import XCTest
@testable import CodingTest_Meteo

class CodingTest_MeteoTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testApi() {
        let exp = expectation(description: "forecast")
        
        let manager = WeatherManager()
        var current: Forecast?
        var error: Error?
        
        manager.current(completion: { (forecast) in
            current = forecast
            exp.fulfill()
        }) { (err) in
            error = err
        }
        
        wait(for: [exp], timeout: 5.0)
        XCTAssertNil(error)
        XCTAssertNotNil(current)
    }

    func testStorage() {
        let exp = expectation(description: "save")
        
        let manager = WeatherManager()
        var current: Forecast?
        var error: Error?
        
        manager.current(completion: { (forecast) in
            current = forecast
            exp.fulfill()
        }) { (err) in
            error = err
        }
        
        wait(for: [exp], timeout: 5.0)
        XCTAssertNil(error)
        XCTAssertNotNil(current)
        
        manager.save()
        let manager2 = WeatherManager()
        manager2.load()
        XCTAssertNotNil(manager2.current)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

