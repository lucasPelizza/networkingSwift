//
//  Mapper.swift
//  Networking
//
//  Created by Lucas Pelizza on 24/07/2019.
//

import Foundation

func mapping<T:Decodable>(data: Data?, response: URLResponse?, error: Error?, completionHandler: @escaping (Result<T, NetworkingError>) -> Void) {
    if error != nil {
        completionHandler(.failure(.networkMissing) )
    }
    
    if let response = response as? HTTPURLResponse {
        let result = handleNetworkResponse(response)
        switch result {
        case .success:
            guard let responseData = data else {
                completionHandler(.failure(NetworkingError.noData))
                return
            }
            do {
                let apiResponse = try JSONDecoder().decode(T.self, from: responseData)
                completionHandler(.success(apiResponse))
            } catch {
                completionHandler(.failure(.unableToDecode))
            }
        case .failure(let networkingError):
            completionHandler(.failure(networkingError))
        }
    }
}

fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String, NetworkingError> {
    switch response.statusCode {
    case 200...299: return .success("Ok")
    case 401...500: return .failure(.authenticationError)
    case 501...599: return .failure(.badRequest)
    case 600: return .failure(.outdated)
    default: return .failure(.failed)
    }
}
