//
//  UserInfoModel.swift
//  PyeonHae
//
//  Created by 정건호 on 2023/08/21.
//

import Foundation

struct UserInfoModel: Codable {
    let timestamp: String
    let data: UserInfoDataModel
}

struct UserInfoDataModel: Codable {
    let id: Int?
    let email: String
    let nickname: String
    let profileImageUrl: String?
    let tags: [TagModel]
    let reviewLikeCount: Int
}
