//
//  NetworkingError.swift
//  Networking
//
//  Created by Lucas Pelizza on 24/07/2019.
//

import Foundation

public enum NetworkingError: Error {
    case authenticationError
    case badRequest
    case outdated
    case failed
    case noData
    case unableToDecode
    case networkMissing
    case parametersNil
    case encodingFailed
    case missingURL
    
}

extension NetworkingError: LocalizedError {
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
        case .parametersNil:
            return "Parameters were nil."
        case .encodingFailed:
            return "Parameter encoding failed."
        case .missingURL:
            return "URL is nil."
        }
    }
}
