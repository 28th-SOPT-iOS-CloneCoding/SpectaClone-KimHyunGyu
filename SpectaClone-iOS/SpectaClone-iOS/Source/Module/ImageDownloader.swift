//
//  ImageDownloader.swift
//  SpectaClone-iOS
//
//  Created by kimhyungyu on 2022/06/03.
//

import UIKit

actor ImageDownloader {
    static let shared = ImageDownloader()
    private init() { }
    
    private var cache: [URL: UIImage] = [:]
    
    func image(from urlPath: String) async throws -> UIImage? {
        guard let url = URL(string: Const.Path.imageURLPath + urlPath) else {
            throw ImageDownloadError.invalidURLString
        }
        
        if let cached = cache[url] {
            return cached
        }
        
        let image = try await downloadImage(from: url)
        
        cache[url] = cache[url, default: image]
        
        return cache[url]!
        
//        guard let cached = cache[url] else {
//            throw ImageDownloadError.unsupportImage
//        }
//
//        return cache[url]
    }

    private func downloadImage(from url: URL) async throws -> UIImage {
        let imageFetchProvider = ImageFetchProvider.shared
        return try await imageFetchProvider.fetchImage(with: url)
    }
}
