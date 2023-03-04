//
//  TagsModel.swift
//  PyeonHae
//
//  Created by 정건호 on 2023/02/28.
//

import Foundation

struct TagsModel: Codable {
    let data: [TagModel]
}

struct TagModel: Codable, Equatable {
    let id: Int
    let name: String
    let group: Int
}
