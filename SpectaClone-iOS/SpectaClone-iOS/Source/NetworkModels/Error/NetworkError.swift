//
//  NetworkError.swift
//  SpectaClone-iOS
//
//  Created by kimhyungyu on 2022/05/21.
//

import Foundation

/// 서버통신 시 발생하는 에러.
enum NetworkError: Error {
    
    /// 디코딩 에러.
    /// - Parameter toType : Deciadable 을 채택하는 디코딩 가능한 자료형. existential metatype 이다.
    case decodError(toType: Decodable.Type)
    
    /// 서버 요청 에러.
    case requestError(_ statusCode: Int)
    
    /// 서버 내부 에러.
    case serverError(_ statusCode: Int)
    
    /// 네트워크 연결 실패 에러.
    case networkFailError(_ statusCode: Int)
}
