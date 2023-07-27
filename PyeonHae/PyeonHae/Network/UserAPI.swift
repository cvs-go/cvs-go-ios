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
}

extension UserAPI {
    
    var method: HTTPMethod {
        switch self {
        case .checkEmail, .checkNickname, .getTags:
            return .get
        case .signUp:
            return .post
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
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .checkEmail, .checkNickname, .getTags:
            return nil
        case .signUp(let parameters):
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
