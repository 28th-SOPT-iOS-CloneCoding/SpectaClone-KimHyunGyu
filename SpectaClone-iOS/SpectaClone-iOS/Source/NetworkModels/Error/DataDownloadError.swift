//
//  DataDownloadError.swift
//  SpectaClone-iOS
//
//  Created by kimhyungyu on 2022/05/12.
//

import Foundation

enum DataDownloadError: Error {
    /// 유효하지 않은 URLComponents 생성 오류.
    case invalidURLComponents
    
    /// 유효하지 않은 URL  형식 오류.
    case invalidURLString
    
    /// 응답으로 HTTPURLResponse 가 오지 않는 유효하지 않은 통신 오류.
    case invalidServerResponse
}
