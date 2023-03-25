//
//  EndPoint.swift
//  PyeonHae
//
//  Created by 정건호 on 2023/03/04.
//

import Foundation
import Alamofire

protocol EndPoint {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: [String : Any]? { get }
    var encoding: ParameterEncoding { get }
    var fullURL: URL { get }
}

extension EndPoint {
    var baseURL: String {
        let baseURL = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String
        return baseURL ?? String()
    }
}
