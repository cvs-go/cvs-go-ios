//
//  ProductsAPI.swift
//  PyeonHae
//
//  Created by 정건호 on 2023/03/25.
//

import Foundation
import Alamofire

enum ProductsAPI: API {
    case filter
}

extension ProductsAPI {
    
    var method: HTTPMethod {
        switch self {
        case .filter:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .filter:
            return "/products/filter"
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .filter:
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

