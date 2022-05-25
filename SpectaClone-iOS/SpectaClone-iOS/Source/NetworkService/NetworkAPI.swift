//
//  API.swift
//  SpectaClone-iOS
//
//  Created by kimhyungyu on 2022/05/20.
//

import Foundation

public struct NetworkAPI {
    
    static let shared = NetworkAPI()
    
    private let provider = NetworkProvider<NetworkService>()
    private init() { }
    
    func fetchPopularMovies(page: Int? = nil) async throws -> PopularMovie {
        
        let request = try provider.request(.popular(page: page))
        
        // MARK: - 통신
        
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw MovieDownloadError.invalidServerResponse
        }
        let networkResult = try self.judgeStatus(by: httpResponse.statusCode, data, type: PopularMovie.self)

        return networkResult
    }

    
    private func judgeStatus<T: Codable>(by statusCode: Int, _ data: Data, type: T.Type) throws -> T {
        switch statusCode {
        case 200:
            return try decodedData(type, from: data)
        case 400..<500:
            throw NetworkError.requestErr
        case 500:
            throw NetworkError.serverErr
        default:
            throw NetworkError.networkFail
        }
    }
    
    private func decodedData<T: Codable>(_ type: T.Type, from data: Data) throws -> T {
        // Moview API 의 response 에 따라서 GenericResponse 와 같이 제네릭을 활용해서 디코딩할 수 없는 경우였다.
        // response 에 공통 요소가(ex. status, success, data 등) 없음.
//        guard let decodedData = try? JSONDecoder().decode(GenericResponse<T>.self, from: data),
//              let data = decodedData.data else {
//            throw NetworkError.decodedErr
//        }
        guard let decodedData = try? JSONDecoder().decode(T.self, from: data) else {
            throw NetworkError.decodedErr
        }
    
        return decodedData
    }
}
