//
//  NewsAPICall.swift
//  TCS_Coding_Test_NewsApp
//
//  Created by Charmy on 4/3/22.
//

import Foundation

class NewsAPICall{
    
    static let shared = NewsAPICall()
    
    public func getTrendingNews(completion : @escaping (Result<[Articles], Error>) -> Void) {
        guard let url = Constants.newsHeadlineUrl else{
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, _ , error) in
            
            if let error = error{
                completion(.failure(error))
            }else if let data = data{
                do{
                    let result = try JSONDecoder().decode(APIResponse.self, from: data)
                    print("Articles: \(result.articles.count)")
                    completion(.success(result.articles))
                }catch{
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
}


