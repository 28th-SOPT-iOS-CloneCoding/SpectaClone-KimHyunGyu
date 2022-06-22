//
//  ImageDownloadError.swift
//  SpectaClone-iOS
//
//  Created by kimhyungyu on 2022/05/12.
//

import Foundation

/// 이미지를 URL 을 통해서 다운받는 과정에서 발생하는 에러.
enum ImageDownloadError: Error {
    
    /// 유효하지 않은 URL 형식 오류.
    case invalidURLString(_ urlPath: String)
    
    /// 유효하지 않은 Server Response 오류.
    case invalidServerResponse
    
    /// 지원하지 않는 Image 오류
    case unsupportImage
}
