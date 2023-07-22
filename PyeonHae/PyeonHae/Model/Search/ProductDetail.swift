//
//  ProductDetail.swift
//  PyeonHae
//
//  Created by 정건호 on 2023/04/26.
//

import Foundation

struct ProductDetail: Codable {
    let timestamp: String
    let data: ProductInfo
}

struct ProductInfo: Codable, Hashable {
    let productId: Int
    let productName: String
    let productPrice: Int
    let productImageUrl: String?
    let manufacturerName: String
    let isLiked: Bool
    let isBookmarked: Bool
    let convenienceStoreEvents: [ConvenienceStoreEvent]
}

struct ConvenienceStoreEvent: Codable, Hashable {
    let name: String
    let eventType: String?
    let discountAmount: Int?
}
