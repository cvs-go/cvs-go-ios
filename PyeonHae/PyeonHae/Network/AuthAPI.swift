//
//  AuthAPI.swift
//  PyeonHae
//
//  Created by 정건호 on 2023/03/25.
//

import Foundation
import Alamofire

enum AuthAPI: API {
    case login([String : String])
    case logout([String : String])
    case tokens
}

extension AuthAPI {
    
    var method: HTTPMethod {
        switch self {
        case .login, .logout:
            return .post
        case .tokens:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .login:
            return "/auth/login"
        case .logout:
            return "/auth/logout"
        case .tokens:
            return "/auth/tokens"
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .login(let parameters):
            return parameters
        case .logout(let parameters):
            return parameters
        case .tokens:
            return nil
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
