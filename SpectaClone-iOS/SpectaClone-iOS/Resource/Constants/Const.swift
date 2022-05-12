//
//  Const.swift
//  SpectaClone-iOS
//
//  Created by kimhyungyu on 2022/05/12.
//

import Foundation

struct Const {
    struct URL {
        static let baseURL = "https://api.themoviedb.org/3"
        static let imageUrl = "https://image.tmdb.org/t/p/original"
    }
    
    struct Endpoint {
        static let popular = "/movie/popular"
    }
    
    struct Key {
        static let key = "?api_key=4803d10b09913b29b376e511c75a63fb"
    }
}
