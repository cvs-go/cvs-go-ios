//
//  ErrorResponse.swift
//  PyeonHae
//
//  Created by 정건호 on 2023/06/10.
//

import Foundation

struct ErrorResponse: Codable {
    let timestamp: String
    let code: String
    let message: String
}
