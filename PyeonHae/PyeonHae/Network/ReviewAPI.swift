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
    case modifyReview(id: Int, parameters: [String : Any])
    case reviewList(parameters: [String : Any])
    case productReview(id: Int, parameters: [String : Any])
    case userReviews(id: Int, parameters: [String : Any])
    case like(id: Int)
    case unlike(id: Int)
    case deleteReview(id: Int)
}

extension ReviewAPI {
    
    var method: HTTPMethod {
        switch self {
        case .writeReview, .like:
            return .post
        case .reviewList, .productReview, .userReviews:
            return .get
        case .modifyReview:
            return .put
        case .unlike, .deleteReview:
            return .delete
        }
    }
    
    var path: String {
        switch self {
        case .writeReview(let id, _):
            return "/products/\(id)/reviews"
        case .modifyReview(let id, _):
            return "/reviews/\(id)"
        case .reviewList:
            return "/reviews"
        case .productReview(let id, _):
            return "/products/\(id)/reviews"
        case .userReviews(let id, _):
            return "/users/\(id)/reviews"
        case .like(let id), .unlike(let id):
            return "/reviews/\(id)/likes"
        case .deleteReview(let id):
            return "/reviews/\(id)"
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .writeReview(_, let parameters), .modifyReview(_, let parameters),
                .productReview(_, let parameters), .userReviews(_, let parameters):
            return parameters
        case .reviewList(let parameters):
            return parameters
        case .like, .unlike, .deleteReview:
            return nil
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
        case .reviewList, .productReview, .userReviews:
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

