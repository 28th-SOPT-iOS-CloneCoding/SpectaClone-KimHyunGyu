//
//  ImageFetchProvider.swift
//  SpectaClone-iOS
//
//  Created by kimhyungyu on 2022/05/26.
//

import UIKit

struct ImageFetchProvider {
    static let shared = ImageFetchProvider()
    private init() { }
    
    /// URL 을 가지고 data 를 다운받아서 UIImage 로 변환하느 메서드.
    /// - Parameter urlString: URL 가 될 String 자료형의 값.
    /// - Returns: 다운 받은 data 를 UIImage 로 변환해서 리턴. 변환되지 않는 경우 에러를 던집니다.
    public func fetchImage(with urlString: String) async throws -> UIImage {
        guard let url = URL(string: Const.Path.imageURLPath + urlString) else {
            throw ImageDownloadError.invalidURLString
        }

        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw ImageDownloadError.invalidServerResponse
        }
        
        guard let image = UIImage(data: data) else {
            throw ImageDownloadError.unsupportImage
        }
        
        return image
    }
}
