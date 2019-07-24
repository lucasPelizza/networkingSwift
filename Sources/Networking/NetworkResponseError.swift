//
//  NetworkResponseError.swift
//  SwiftUI News
//
//  Created by Lucas Pelizza on 13/07/2019.
//  Copyright © 2019 Lucas Pelizza. All rights reserved.
//

import Foundation

public enum NetworkResponseError: Error {
    case authenticationError
    case badRequest
    case outdated
    case failed
    case noData
    case unableToDecode
    case networkMissing

}

extension NetworkResponseError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .authenticationError:
            return "Authenticattion failed"
        case .badRequest:
            return "Bad request"
        case .outdated:
            return "Url is outdated"
        case .failed:
            return "Network request failed"
        case .noData:
            return "Response returned no data"
        case .unableToDecode:
            return "Decode failed"
        case .networkMissing:
            return "Please check your network connection"
        }
    }
}
