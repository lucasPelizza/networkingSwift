//
//  HTTPTask.swift
//  SwiftUI News
//
//  Created by Lucas Pelizza on 13/07/2019.
//  Copyright © 2019 Lucas Pelizza. All rights reserved.
//

import Foundation

public typealias HTTPHeaders = [String:String]

public enum HTTPTask {
    case request

    case requestParameters(bodyParameters: Parameters?,
        bodyEncoding: ParameterEncoding,
        urlParameters: Parameters?)

    case requestParametersAndHeaders(bodyParameters: Parameters?,
        bodyEncoding: ParameterEncoding,
        urlParameters: Parameters?,
        additionHeaders: HTTPHeaders?)

    // We could add the other cases like: download, upload, etc.
}
