//
//  MovieDownloadError.swift
//  SpectaClone-iOS
//
//  Created by kimhyungyu on 2022/05/12.
//

import Foundation

enum MovieDownloadError: Error {
    case invalidURLString
    // FIXME: - 네이밍 변경해야할듯
    case invalidServerResponse
    case invalidHTTPURLResponse
}
