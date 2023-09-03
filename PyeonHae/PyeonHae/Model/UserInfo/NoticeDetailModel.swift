//
//  NoticeDetailModel.swift
//  PyeonHae
//
//  Created by 정건호 on 2023/09/03.
//

import Foundation

struct NoticeDetailModel: Codable {
    let timestamp: String
    let data: NoticeDetailContent
}

struct NoticeDetailContent: Codable {
    let id: Int
    let title: String
    let content: String
    let noticeImageUrls: [String]?
    let createdAt: String?
}
