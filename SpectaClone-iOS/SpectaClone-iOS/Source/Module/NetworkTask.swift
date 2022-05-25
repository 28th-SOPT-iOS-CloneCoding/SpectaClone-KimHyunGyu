//
//  NetworkTask.swift
//  SpectaClone-iOS
//
//  Created by kimhyungyu on 2022/05/20.
//

import Foundation

public enum NetworkTask {
    
    /// A request with no additional data.
    case reqiestPlan
    
    case requestParameters(parameters: [String : Any], encoding: ParameterEncoding)
}
