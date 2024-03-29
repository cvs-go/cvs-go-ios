//
//  NoticeListModel.swift
//  PyeonHae
//
//  Created by 정건호 on 2023/08/24.
//

import Foundation

struct NoticeListModel: Codable {
    let timestamp: String
    let data: NoticeContentsModel
}

struct NoticeContentsModel: Codable {
    let content: [NoticeContentModel]
    let totalElements: Int
    let totalPages: Int
}

struct NoticeContentModel: Codable, Hashable {
    let id: Int
    let title: String
    let createdAt: String
    let new: Bool
}
