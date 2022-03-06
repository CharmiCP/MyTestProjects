//
//  InternetAvailabilityUnitTest.swift
//  TCS_Coding_Test_NewsAppTests
//
//  Created by Charmy on 6/3/22.
//

import XCTest
@testable import TCS_Coding_Test_NewsApp

class InternetAvailabilityUnitTest: XCTestCase {
    
    var internetAvailability = InternetAvailableValidation()

    func testIsInternetAvailable(){
        XCTAssertTrue(internetAvailability.isInternetAvailable())
    }
    
    

}

