//
//  NetworkService.swift
//  SpectaClone-iOS
//
//  Created by kimhyungyu on 2022/05/20.
//

import Foundation

enum NetworkService {
    
    /// 인기있는 영화 목록을 가져오는 서버통신.
    /// - Parameter page : pagination 을 지원하는 파라미터. Default is nil.
    case popular(page: Int? = nil)
    
    /// 이미지를 가져오는 서버통신.
    /// - Parameter option : request parameter 로 이미지 사이즈 옵션을 전달하는 파라미터. Default is original.
    /// - Parameter url : option 뒤에 붙을 URL.
    case fetchImage(option: ImageSizeOptions = .original, url: String)
}

/// 해당 open API  에서 지원하는 이미지 사이즈 옵션.
enum ImageSizeOptions: String {
    case original = "original"
    case w500 = "w500"
}

extension NetworkService: TargetType {
    var baseURLPath: String {
        switch self {
        case .popular(_):
            return Const.Path.baseURLPath
        case .fetchImage(_, _):
            return Const.Path.imageURLPath
        }
    }
    
    var path: String {
        switch self {
        case .popular(let page):
            if let page = page {
                return "/movie/popular/\(page)"
            } else {
                return "/movie/popular"
            }
        case .fetchImage(let option, let url):
            return "/\(option.rawValue)/\(url)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .popular(_):
            return .get
        case .fetchImage(_, _):
            return .get
        }
    }
    
    var task: NetworkTask {
        switch self {
        case .popular(let page):
            let parameters: [String : Any]
            if let page = page {
                parameters = ["api_key" : Const.Key.apiKey,
                              "page" : page]
            } else {
                parameters = ["api_key" : Const.Key.apiKey]
            }
            return .requestParameters(parameters: parameters, encoding: .queryString)
        case .fetchImage(_, _):
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .popular(_):
            return nil
        case .fetchImage(_, _):
            return nil
        }
    }
}

