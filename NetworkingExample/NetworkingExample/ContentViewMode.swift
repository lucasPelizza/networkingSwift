
//
//  Services.swift
//  NetworkingExample
//
//  Created by Lucas Pelizza on 24/07/2019.
//  Copyright © 2019 Lucas Pelizza. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class ContentViewModel: BindableObject {
    
    let didChange = PassthroughSubject<ContentViewModel, Never>()
    
    var articles = [Article]() {
        didSet {
            didChange.send(self)
        }
    }
    
    func fetchNews() {
        let parameters = [URLQueryItem(name: "country", value: "us"),
                          URLQueryItem(name: "apiKey", value: "0cf790498275413a9247f8b94b3843fd")]
        
        Services.articles.get(urlParameters: parameters) { (result: Result<NewsPage, NetworkingError>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let articles):
                    self.articles = articles.map(ArticlePresenter.init)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}

struct NewsPage: Codable {
    let articles: [Article]
}

struct Article: Codable {
    let content: String?
    let description: String?
    let imageUrl: String?
    let title: String
    
    public enum CodingKeys: String, CodingKey {
        case content
        case description
        case imageUrl = "urlToImage"
        case title
    }
}
