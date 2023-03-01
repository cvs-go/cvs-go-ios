//
//  LoginAPI.swift
//  PyeonHae
//
//  Created by 정건호 on 2023/02/27.
//

import Foundation
import Alamofire

enum LoginAPI: API {
    case getTags
}

extension LoginAPI {
    
    var method: HTTPMethod {
        switch self {
        case .getTags:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .getTags:
            return "/tags"
        }
    }
    
    var parameters: [String : String]? {
        switch self {
        case .getTags:
            return nil
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
        case .getTags:
            return JSONEncoding.default
        }
    }
    
    var fullURL: URL {
        return URL(string: baseURL + path)!
    }
}
