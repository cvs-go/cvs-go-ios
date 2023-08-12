//
//  UserAPI.swift
//  PyeonHae
//
//  Created by 정건호 on 2023/02/27.
//

import Foundation
import Alamofire

enum UserAPI: API {
    case checkEmail(email: String)
    case checkNickname(nickname: String)
    case getTags
    case signUp([String : Any])
    case editInfo([String : Any])
    case userLikeList(id: Int, parameters: [String : Any])
    case userBookmarkList(id: Int, parameters: [String : Any])
}

extension UserAPI {
    
    var method: HTTPMethod {
        switch self {
        case .checkEmail, .checkNickname, .getTags, .userLikeList, .userBookmarkList:
            return .get
        case .signUp:
            return .post
        case .editInfo:
            return .put
        }
    }
    
    var path: String {
        switch self {
        case .checkEmail(let email):
            return "/users/emails/\(email)/exists"
        case .checkNickname(let nickname):
            return "/users/nicknames/\(nickname)/exists"
        case .getTags:
            return "/tags"
        case .signUp:
            return "/users"
        case .editInfo:
            return "/user"
        case .userLikeList(let id, _):
            return "/users/\(id)/liked-products"
        case .userBookmarkList(let id, _):
            return "/users/\(id)/bookmarked-products"
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .checkEmail, .checkNickname, .getTags:
            return nil
        case .signUp(let parameters), .userBookmarkList(_, let parameters),
                .userLikeList(_ ,let parameters), .editInfo(let parameters):
            return parameters
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
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
