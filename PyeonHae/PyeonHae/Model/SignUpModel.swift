//
//  SignUpModel.swift
//  PyeonHae
//
//  Created by 정건호 on 2023/03/02.
//

import Foundation

struct SignUpModel: Codable {
    let data: SignUpDataModel
}

struct SignUpDataModel: Codable {
    let tagIds: [Int]
    let nickname: String
    let role: String
    let email: String
}
