//
//  GenericResponse.swift
//  SpectaClone-iOS
//
//  Created by kimhyungyu on 2022/05/20.
//

import Foundation

struct GenericResponse<T: Codable>: Codable {
    let data: T?
    
    enum CodingKeys: String, CodingKey {
        case data
    }
}
