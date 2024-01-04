//
//  Products.swift
//  PyeonHae
//
//  Created by 정건호 on 2023/04/19.
//

import Foundation

struct ProductModel: Codable {
    let timestamp: String
    var data: Products
}

struct Products: Codable {
    var content: [Product]
    var totalElements: Int
    var last: Bool
}

struct Product: Codable, Hashable, Identifiable {
    let id = UUID()
    var productId: Int
    let productName: String
    let productPrice: Int
    let productImageUrl: String?
    let categoryId: Int
    let manufacturerName: String
    var isLiked: Bool
    var isBookmarked: Bool
    let reviewCount: Int
    let reviewRating: String
    let convenienceStoreEvents: [ConvenienceStoreEvents]
    
    private enum CodingKeys: CodingKey {
        case productId
        case productName
        case productPrice
        case productImageUrl
        case categoryId
        case manufacturerName
        case isLiked
        case isBookmarked
        case reviewCount
        case reviewRating
        case convenienceStoreEvents
    }
}

struct ConvenienceStoreEvents: Codable, Hashable {
    let name: String
    let eventType: String?
    let discountAmount: Int?
}
