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
    case reviewList(parameters: [String : Any])
    case productReview(id: Int, parameters: [String : Any])
}

extension ReviewAPI {
    
    var method: HTTPMethod {
        switch self {
        case .writeReview:
            return .post
        case .reviewList:
            return .get
        case .productReview:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .writeReview(let id, _):
            return "/products/\(id)/reviews"
        case .reviewList:
            return "/reviews"
        case .productReview(let id, _):
            return "/products/\(id)/reviews"
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .writeReview(_, let parameters), .productReview(_, let parameters):
            return parameters
        case .reviewList(let parameters):
            return parameters
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
        case .reviewList, .productReview:
            return URLEncoding.default
        default:
            return JSONEncoding.default
        }
    }
    
    var fullURL: URL {
        var urlComponents = URLComponents(string: baseURL)!
        urlComponents.path += path
        return urlComponents.url!
    }
}

