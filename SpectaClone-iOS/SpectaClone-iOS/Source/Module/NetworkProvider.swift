//
//  NetworkProvider.swift
//  SpectaClone-iOS
//
//  Created by kimhyungyu on 2022/05/20.
//

import Foundation

struct NetworkProvider<Target: TargetType> {
    func request(_ target: Target) throws -> URLRequest {
        
        // url path
        let path = target.baseURLPath + target.path
        guard var urlComponents = URLComponents(string: path) else {
            throw DataDownloadError.invalidURLComponents
        }
        
        // task
        var url: URL?
        let task = target.task
        switch task {
        case .requestPlain:
            url = urlComponents.url
        case .requestParameters(let parameters, let encoding):
            switch encoding {
            case .queryString:
                // parameter query
                let queryItemArray = parameters.map {
                    URLQueryItem(name: $0.key, value: $0.value as? String)
                }
                urlComponents.queryItems = queryItemArray
                url = urlComponents.url
            }
        }
        guard let url = url else {
            throw DataDownloadError.emptyURL
        }
        
        // method
        var request = URLRequest(url: url)
        request.httpMethod = target.method.rawValue
        
        // header
        if let headerField = target.headers {
            _ = headerField.map { (key, value) in
                request.addValue(value, forHTTPHeaderField: key)
            }
        }
        
        return request
    }
}
