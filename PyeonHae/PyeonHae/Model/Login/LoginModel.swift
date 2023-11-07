//
//  LoginModel.swift
//  PyeonHae
//
//  Created by 정건호 on 2023/03/03.
//

import Foundation

struct LoginModel: Codable {
    let timestamp: String
    let data: LoginDataModel
}

struct LoginDataModel: Codable {
    let userId: Int
    let token: TokenModel
}

struct TokenModel: Codable {
    let accessToken: String
    let refreshToken: String
    let tokenType: String
}
