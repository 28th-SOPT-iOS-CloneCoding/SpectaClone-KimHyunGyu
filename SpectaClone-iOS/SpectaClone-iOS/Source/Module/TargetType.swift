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

    /// 실제로는 사용되지 않으나 extension 을 활용하여 protocol method 의 기본값을 설정할 수 있음을 확인.
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
