//
//  RequestGenerator.swift
//  Networking
//
//  Created by Lucas Pelizza on 24/07/2019.
//

import Foundation

func performRequest(apiService: APIServices,
                    method: HTTPMethod,
                    urlParameters: [URLQueryItem]?,
                    bodyParameters: [String:Any]?,
                    headers: [String:String]?,
                    session: URLSession,
                    completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) throws -> URLSessionTask {
    
    let urlComponents = URLComponents(queryItems: urlParameters, apiService: apiService)
    
    guard let url = urlComponents.url else { fatalError() }
    
    var request = URLRequest(url: url)
    request.httpMethod = HTTPMethod.post.rawValue
    
    if let headers = headers {
        insert(headers:headers, in: &request)
    }
    
    if let body = bodyParameters {
        try insertBody(body: body, in: &request)
    }
    
    let task = session.dataTask(with: request) { completionHandler($0,$1,$2) }
    task.resume()
    return task
}

fileprivate func insert(headers: [String:String], in request: inout URLRequest) {
    for (key, value) in headers {
        request.setValue(value, forHTTPHeaderField: key)
    }
}

fileprivate func insertBody(body: [String:Any], in request: inout URLRequest) throws {
    do {
        let jsonAsData = try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
        request.httpBody = jsonAsData
        if request.value(forHTTPHeaderField: "Content-Type") == nil {
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
    } catch {
        throw NetworkingError.encodingFailed
    }
}

