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
    case product(id: Int)
    case tags(id: Int)
    case like(id: Int)
    case unlike(id: Int)
    case bookmark(id: Int)
    case unbookmark(id: Int)
    case promotions
}

extension ProductsAPI {
    
    var method: HTTPMethod {
        switch self {
        case .filter, .search, .product, .tags, .promotions:
            return .get
        case .like, .bookmark:
            return .post
        case .unlike, .unbookmark:
            return .delete
        }
    }
    
    var path: String {
        switch self {
        case .filter:
            return "/products/filter"
        case .search:
            return "/products"
        case .product(let id):
            return "/products/\(id)"
        case .tags(let id):
            return "/products/\(id)/tags"
        case .like(let id), .unlike(let id):
            return "/products/\(id)/likes"
        case .bookmark(let id), .unbookmark(let id):
            return "/products/\(id)/bookmarks"
        case .promotions:
            return "/promotions"
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .search(let parameters):
            return parameters
        default:
            return nil
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

