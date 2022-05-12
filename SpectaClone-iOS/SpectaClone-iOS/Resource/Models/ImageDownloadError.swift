//
//  ImageDownloadError.swift
//  SpectaClone-iOS
//
//  Created by kimhyungyu on 2022/05/12.
//

import Foundation

enum ImageDownloadError: Error {
    case invalidURLString
    case invalidServerResponse
    case unsupportImage
}
