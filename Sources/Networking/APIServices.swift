//
//  APIServices.swift
//  SwiftUI News
//
//  Created by Lucas Pelizza on 13/07/2019.
//  Copyright © 2019 Lucas Pelizza. All rights reserved.
//

import Foundation

public protocol APIServices {
    var host: String { get }
    var path: String { get }
    var scheme: SchemeType { get }
    var httpMethod: HTTPMethod { get }
    var headers: [String : String]? { get }
}

extension APIServices {
    public func fetch<T:Decodable>(urlParameters: [URLQueryItem]? = nil,
                            session: URLSession = URLSession.shared,
                            completionHandler: @escaping (Result<T, NetworkingError>) -> Void) -> URLSessionTask? {
        do {
            return try performRequest(apiService: self,
                                      method: HTTPMethod.get,
                                      urlParameters: urlParameters,
                                      bodyParameters: nil,
                                      headers: self.headers,
                                      session: session) { data, response, error in
                                        
                                        mapping(data: data, response: response, error: error, completionHandler: completionHandler)
            }
        } catch {
            completionHandler(.failure(.encodingFailed))
            return nil
        }
    }
    
    public func post<T:Decodable>(bodyParameters: [String:Any]?,
                           session: URLSession = URLSession.shared,
                           completionHandler: @escaping (Result<T, NetworkingError>) -> Void) -> URLSessionTask? {
        
        do {
            return try performRequest(apiService: self,
                                      method: HTTPMethod.post,
                                      urlParameters: nil,
                                      bodyParameters: bodyParameters,
                                      headers: self.headers,
                                      session: session) { data, response, error in
                                        
                                        mapping(data: data, response: response, error: error, completionHandler: completionHandler)
            }
        } catch {
            completionHandler(.failure(.encodingFailed))
            return nil
        }
    }
}

