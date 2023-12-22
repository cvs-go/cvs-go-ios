//
//  UserReviewListModel.swift
//  PyeonHae
//
//  Created by 정건호 on 12/21/23.
//

import Foundation

struct UserReviewListModel: Codable {
    let timestamp: String
    let data: UserReviewsModel
}

struct UserReviewsModel: Codable {
    let content: [UserReviewDataModel]
    let totalElements: Int
}

struct UserReviewDataModel: Codable, Hashable {
    let productId: Int
    let productName: String
    let productManufacturer: String
    let productImageUrl: String?
    let reviewId: Int
    let reviewerId: Int
    let reviewerNickname: String
    let reviewerProfileImageUrl: String?
    let reviewLikeCount: Int
    let reviewRating: Int
    let reviewContent: String
    let isReviewLiked: Bool
    let isProductBookmarked: Bool
    let reviewImageUrls: [String]?
    let createdAt: String
}
