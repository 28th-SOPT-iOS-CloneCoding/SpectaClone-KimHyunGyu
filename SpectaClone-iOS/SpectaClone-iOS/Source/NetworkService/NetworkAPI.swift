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
            throw DataDownloadError.invalidServerResponse
        }
        
        let networkResult = try self.judgeStatus(by: httpResponse.statusCode, data, type: PopularMovie.self)

        return networkResult
    }

    /// 상태코드를 가지고 에러 핸들링하는 메서드.
    /// - Parameter statusCode : 상태 코드.
    /// - Parameter data : 디코딩 할 JSON 객체.
    /// - Parameter type : JSON 객체로 부터 디코딩 당할 값의 자료형.
    private func judgeStatus<T: Codable>(by statusCode: Int, _ data: Data, type: T.Type) throws -> T {
        switch statusCode {
        case 200:
            return try decodeData(from: data, to: type)
        case 400..<500:
            throw NetworkError.requestError(statusCode)
        case 500:
            throw NetworkError.serverError(statusCode)
        default:
            throw NetworkError.networkFailError(statusCode)
        }
    }
    
    /// 디코딩하고, 에러를 핸들링하는 메서드.
    /// - Parameter data : 디코딩 할 JSON 객체.
    /// - Parameter type : JSON 객체로 부터 디코딩 당할 값의 자료형.
    private func decodeData<T: Codable>(from data: Data, to type: T.Type) throws -> T {
        // Moview API 의 response 에 따라서 GenericResponse 와 같이 제네릭을 활용해서 디코딩할 수 없는 경우였다.
        // response 에 공통 요소가(ex. status, success, data 등) 없음.
//        guard let decodedData = try? JSONDecoder().decode(GenericResponse<T>.self, from: data),
//              let data = decodedData.data else {
//            throw NetworkError.decodError(toType: T.self)
//        }
        
        guard let decodedData = try? JSONDecoder().decode(T.self, from: data) else {
            throw NetworkError.decodError(toType: T.self)
        }
    
        return decodedData
    }
}
