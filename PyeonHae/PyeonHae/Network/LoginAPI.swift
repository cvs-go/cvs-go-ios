//
//  LoginAPI.swift
//  PyeonHae
//
//  Created by 정건호 on 2023/02/27.
//

import Foundation
import Alamofire

enum LoginAPI: API {
    case checkEmail(email: String)
    case checkNickname(nickname: String)
    case getTags
    case signUp([String : Any]?)
}

extension LoginAPI {
    
    var method: HTTPMethod {
        switch self {
        case .checkEmail:
            return .get
        case .checkNickname:
            return .get
        case .getTags:
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
            return "/users/nicknames/\(nickname)/exists".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        case .getTags:
            return "/tags"
        case .signUp:
            return "/users"
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .checkEmail:
            return nil
        case .checkNickname:
            return nil
        case .getTags:
            return nil
        case .signUp(let parameters):
            return parameters
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
        case .checkEmail:
            return JSONEncoding.default
        case .checkNickname:
            return JSONEncoding.default
        case .getTags:
            return JSONEncoding.default
        case .signUp:
            return JSONEncoding.default
        }
    }
    
    var fullURL: URL {
        return URL(string: baseURL + path)!
    }
}
