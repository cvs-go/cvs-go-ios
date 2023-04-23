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
    case search([String : Any])
}

extension ProductsAPI {
    
    var method: HTTPMethod {
        switch self {
        case .filter, .search:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .filter:
            return "/products/filter"
        case .search:
            return "/products"
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .filter:
            return nil
        case .search(let parameters):
            return parameters
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
        case .search:
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

