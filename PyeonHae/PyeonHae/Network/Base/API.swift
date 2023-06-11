//
//  API.swift
//  PyeonHae
//
//  Created by 정건호 on 2023/03/01.
//

import Foundation
import Alamofire

protocol API: EndPoint {}

extension API {
    // Default Content-Type: application/json
    var headers: HTTPHeaders {
        var headers = HTTPHeaders()
        headers.add(HTTPHeader.contentType("application/json"))
        return headers
    }
}
