//
//  NetworkError.swift
//  SpectaClone-iOS
//
//  Created by kimhyungyu on 2022/05/21.
//

import Foundation

enum NetworkError: Error {
    case decodedErr     // 디코딩 에러
    case requestErr     // 서버 요청 에러
    case serverErr      // 서버 내부 에러
    case networkFail    // 네트워크 연결 실패
}
