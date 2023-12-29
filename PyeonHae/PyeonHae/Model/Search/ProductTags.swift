//
//  ProductTags.swift
//  PyeonHae
//
//  Created by 정건호 on 12/12/23.
//

import Foundation

struct ProductTags: Codable {
    let timestamp: String
    let data: [ProductTagsModel]
}

struct ProductTagsModel: Codable, Hashable {
    let id: Int
    let name: String
    let tagCount: Int
}
