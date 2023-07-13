//
//  Products.swift
//  PyeonHae
//
//  Created by 정건호 on 2023/04/19.
//

import Foundation

struct ProductModel: Codable {
    let timestamp: String
    let data: Products
}

struct Products: Codable {
    let content: [Product]
    let totalElements: Int
}

struct Product: Codable, Hashable {
    let productId: Int
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
    
    mutating func updateIsLikedValue(_ isLiked: Bool) {
        self.isLiked = isLiked
    }
    
    mutating func updateIsBookmarkedValue(_ isBookmarked: Bool) {
        self.isBookmarked = isBookmarked
    }
}

struct ConvenienceStoreEvents: Codable, Hashable {
    let name: String
    let eventType: String?
    let discountAmount: Int?
}
