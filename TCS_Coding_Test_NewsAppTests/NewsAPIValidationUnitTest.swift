//
//  NewsAPIValidationUnitTest.swift
//  TCS_Coding_Test_NewsAppTests
//
//  Created by Charmy on 6/3/22.
//

import XCTest
@testable import TCS_Coding_Test_NewsApp

class NewsAPIValidationUnitTest: XCTestCase {
    
    var apiValidation = APIValidation()

    func testNewsAPIValidation_isEmpty(){
        XCTAssertFalse(apiValidation.validateAPI())
    }
    
    

}
