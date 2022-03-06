//
//  APIValidation.swift
//  TCS_Coding_Test_NewsApp
//
//  Created by Charmy on 6/3/22.
//

import Foundation

class APIValidation{
    
    func validateAPI() -> Bool{
        let apiStr = Constants.newsHeadlineUrl
        let isEmpty = (apiStr?.absoluteString == nil ? true : false)
        return isEmpty
    }
    
}
