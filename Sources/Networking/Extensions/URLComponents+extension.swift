//
//  URLComponents+extension.swift
//  Networking
//
//  Created by Lucas Pelizza on 24/07/2019.
//

import Foundation
extension URLComponents {
    init(queryItems: [URLQueryItem]?, apiService: APIServices) {
        self.init()
        self.scheme = apiService.scheme.rawValue
        self.host = apiService.host
        self.path = apiService.path
        self.queryItems = queryItems
    }
}
