//
//  APIs.swift
//  FlickrPhotos
//
//  Created by Ahmed Abuelmagd on 30/05/2021.
//

import Foundation
import Moya


enum EndPoints: String {
    case PHOTOS = "rest/"
}

enum APIs {
    case getPhotos (method: String, page: Int, format: String, nojsoncallback: Int, api_key: String, text: String, per_page: Int)
}

extension APIs: TargetType {
    var baseURL: URL {
        guard let url = URL(string: Config.BASE_URL) else { fatalError("baseURL could not be configured.")}
        return url
    }
    var path: String {
        switch self {
        case .getPhotos: return EndPoints.PHOTOS.rawValue
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getPhotos: return .post
        }

    }
    
    var task: Task {
        switch self {
        case .getPhotos(let method, let page, let format, let nojsoncallback, let api_key, let text, let per_page):
            return .requestParameters(parameters: ["method": method, "page": page,"format": format, "nojsoncallback": nojsoncallback,"api_key": api_key, "text": text, "per_page": per_page], encoding: URLEncoding.queryString)
        }
    }

    var sampleData: Data {
        return Data()
    }
        
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
    
    
}
