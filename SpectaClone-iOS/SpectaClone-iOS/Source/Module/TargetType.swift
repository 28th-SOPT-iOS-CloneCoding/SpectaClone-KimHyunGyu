//
//  TargetType.swift
//  SpectaClone-iOS
//
//  Created by kimhyungyu on 2022/05/20.
//

import Foundation

public protocol TargetType {
    /// The target's base `URL`.
    var baseURLPath: String { get }

    /// The path to be appended to `baseURL` to form the full `URL`.
    var path: String { get }

    /// The HTTP method used in the request.
    var method: HTTPMethod { get }

    /// Provides stub data for use in testing. Default is `Data()`.
    var sampleData: Data { get }

    /// The type of HTTP task to be performed.
    var task: NetworkTask { get }


    /// The headers to be used in the request.
    var headers: [String: String]? { get }
}

public extension TargetType {

    /// Provides stub data for use in testing. Default is `Data()`.
    var sampleData: Data { Data() }
}
