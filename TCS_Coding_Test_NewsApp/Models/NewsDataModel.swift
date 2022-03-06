//
//  NewsDataModel.swift
//  TCS_Coding_Test_NewsApp
//
//  Created by Charmy on 6/3/22.
//

import Foundation

struct APIResponse : Codable {
    let articles : [Articles]
}

struct Articles : Codable {
    let source : Source
    let title : String
    let description : String?
    let url : String?
    let urlToImage : String?
}

struct Source : Codable {
    let name : String
}

struct Constants{
    static let newsHeadlineUrl = URL(string: "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=b857668dbb284a4a9ff57636f15069de")
}
