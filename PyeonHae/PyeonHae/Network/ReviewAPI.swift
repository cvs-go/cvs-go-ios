//
//  ReviewAPI.swift
//  PyeonHae
//
//  Created by 정건호 on 2023/06/06.
//

import Foundation
import Alamofire

enum ReviewAPI: API {
    case writeReview(id: Int, parameters: [String : Any])
}

extension ReviewAPI {
    
    var method: HTTPMethod {
        switch self {
        case .writeReview:
            return .post
        }
    }
    
    var headers: HTTPHeaders {
        var headers = HTTPHeaders()
        headers.add(HTTPHeader.contentType("application/x-www-form-urlencoded"))
        return headers
    }
    
    var path: String {
        switch self {
        case .writeReview(let id, _):
            return "/products/\(id)/reviews"
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .writeReview(_, let parameters):
            return parameters
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
        default:
            return URLEncoding.httpBody
        }
    }
    
    var fullURL: URL {
        var urlComponents = URLComponents(string: baseURL)!
        urlComponents.path += path
        return urlComponents.url!
    }
}

