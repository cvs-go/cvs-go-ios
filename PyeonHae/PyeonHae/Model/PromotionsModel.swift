//
//  PromotionsModel.swift
//  PyeonHae
//
//  Created by 정건호 on 12/4/23.
//

import Foundation

struct PromotionsModel: Codable {
    let timestamp: String
    let data: PromotionData
}

struct PromotionData: Codable {
    let content: [PromotionContent]
    let totalElements: Int
}

struct PromotionContent: Codable, Equatable {
    let id: Int
    let imageUrl: String
    let landingUrl: String
}
