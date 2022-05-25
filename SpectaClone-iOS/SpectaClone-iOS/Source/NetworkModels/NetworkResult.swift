//
//  NetworkResult.swift
//  SpectaClone-iOS
//
//  Created by kimhyungyu on 2022/05/20.
//

import Foundation

enum NetworkResult<T> {
    case success(T) // 서버 통신 성공
    case requestErr // 요청 에러 발생
    case serverErr // 서버의 내부적 에러
    case networkFail // 네트워크 연결 실패
}