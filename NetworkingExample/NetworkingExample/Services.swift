//
//  Services.swift
//  NetworkingExample
//
//  Created by Lucas Pelizza on 24/07/2019.
//  Copyright © 2019 Lucas Pelizza. All rights reserved.
//

public enum Services {
    case articles
}

extension Services: APIServices {
    
    var scheme: SchemeType {
        switch self {
        case .articles:
            return .https
        default:
            return .http
        }
    }
    
    var host: String {
        return "newsapi.org"
    }
    
    var path: String {
        switch self {
        case .articles:
            return "/v2/top-headlines"
        default:
            return ""
        }
    }
    
    var headers: [String : String]? {
        switch self {
        default:
            return ["Content-type": "application/json"]
        }
    }
}



