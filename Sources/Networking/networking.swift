//
//  Networking.swift
//  SwiftUI News
//
//  Created by Lucas Pelizza on 13/07/2019.
//  Copyright © 2019 Lucas Pelizza. All rights reserved.
//

import Foundation

public struct Networking {
    let isConsoleLogEnable: Bool
    let router: NetworkRouter

    public func request<T: Codable>(endpointType: EndpointType, completionHandler: @escaping (Result<T, NetworkResponseError>) -> Void ) {
        router.request(endpointType) { data, response, error in
            if error != nil {
                completionHandler(.failure(.networkMissing) )
            }

            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completionHandler(.failure(NetworkResponseError.noData))
                        return
                    }
                    do {
                        self.consoleLog(responseData)
                        let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
                        self.consoleLog(jsonData)
                        let apiResponse = try JSONDecoder().decode(T.self, from: responseData)
                        completionHandler(.success(apiResponse))
                    } catch {
                        self.consoleLog(error)
                        completionHandler(.failure( NetworkResponseError.unableToDecode))
                    }
                case .failure(let networkFailureError):
                    completionHandler(.failure(networkFailureError))
                }
            }
        }
    }

    fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String, NetworkResponseError> {
        switch response.statusCode {
        case 200...299: return .success("Ok")
        case 401...500: return .failure(NetworkResponseError.authenticationError)
        case 501...599: return .failure(NetworkResponseError.badRequest)
        case 600: return .failure(NetworkResponseError.outdated)
        default: return .failure(NetworkResponseError.failed)
        }
    }

    private func consoleLog(_ text: Any) {
        if isConsoleLogEnable {
            print(text)
        }
    }
}
