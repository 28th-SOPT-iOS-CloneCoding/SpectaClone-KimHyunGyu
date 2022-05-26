//
//  ImageDownloadError.swift
//  SpectaClone-iOS
//
//  Created by kimhyungyu on 2022/05/12.
//

import Foundation

enum ImageDownloadError: Error {
    /// 유효하지 않은 URL 형식 오류.
    case invalidURLString
    
    /// 유효하지 않은 Server Response 오류.
    case invalidServerResponse
    
    /// 지원하지 않는 Image 오류
    case unsupportImage
}
