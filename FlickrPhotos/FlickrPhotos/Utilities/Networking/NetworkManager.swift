//
//  NetworkManager.swift
//  FlickrPhotos
//
//  Created by Ahmed Abuelmagd on 30/05/2021.
//

import Foundation
import Moya

// MARK: - Error
enum GetApiFailureReason: Int, Error {
    case unAuthorized = 401
    case badRequest = 400
    case notFound = 404
    case apiError = 500
    case notHandleStatusCode = 0
}

extension GetApiFailureReason {
    func getErrorMessage() -> String? {
        switch self {
        case .unAuthorized: return Errors.UNAUTHORIZED.rawValue
        case .notFound: return Errors.UNKNOWN.rawValue
        case .badRequest: return Errors.BAD_REQUEST.rawValue
        case .apiError: return Errors.UNKNOWN.rawValue
        case .notHandleStatusCode: return Errors.UNKNOWN.rawValue
        }
    }
}
protocol NetworkProtocol {
    func getPhotos(method: String, page: Int, format: String, nojsoncallback: Int, api_key: String, text: String, per_page: Int, completionHandler: @escaping (Result<PhotosModel, Error>)->())

}
class NetworkManager {
    let provider = MoyaProvider<APIs>(plugins: [NetworkLoggerPlugin()])
    
    private func fetchData<M: Decodable>(target: APIs, responseClass: M.Type, completionHandler: @escaping (Result<M, Error>)->()) {
        provider.request(target) { result in
            switch result {
            case .success(let response):
                if response.statusCode == 200 {
                    do {
                        let model = try JSONDecoder().decode(M.self, from: response.data)
                        completionHandler(.success(model))
                    }catch let error{
                        completionHandler(.failure(error))
                    }
                }else {
                    if let reason = GetApiFailureReason(rawValue: response.statusCode) {
                         completionHandler(.failure(reason))
                    }else {
                        completionHandler(.failure(GetApiFailureReason.notHandleStatusCode))
                    }
                }

            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}
extension NetworkManager: NetworkProtocol {
    func getPhotos(method: String, page: Int, format: String, nojsoncallback: Int, api_key: String, text: String, per_page: Int, completionHandler: @escaping (Result<PhotosModel, Error>) -> ()) {
        fetchData(target: .getPhotos(method: method, page: page, format: format, nojsoncallback: nojsoncallback, api_key: api_key, text: text, per_page: per_page), responseClass: PhotosModel.self) { result in
                    completionHandler(result)
        }
    }
}
