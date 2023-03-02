//
//  API.swift
//  PyeonHae
//
//  Created by 정건호 on 2023/03/01.
//

import Foundation
import Alamofire

protocol API {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: [String : Any]? { get }
    var encoding: ParameterEncoding { get }
    var fullURL: URL { get }
}

extension API {
    var baseURL: String {
        return Constants.URL.baseURL
    }
}
