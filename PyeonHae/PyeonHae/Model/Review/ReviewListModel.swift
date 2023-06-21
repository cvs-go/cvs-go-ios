//
//  ReviewListModel.swift
//  PyeonHae
//
//  Created by 정건호 on 2023/06/21.
//

import Foundation

struct ReviewListModel: Codable {
    let timestamp: String
    let data: ReviewsModel
}

struct ReviewsModel: Codable {
    let latestReviewCount: Int
    let reviews: [ReviewDataModel]
}

struct ReviewDataModel: Codable, Hashable {
    let productId: Int
    let productName: String
    let productManufacturer: String
    let productImageUrl: String?
    let reviewId: Int
    let reviewerId: Int
    let reviewerNickname: String
    let reviewerProfileImageUrl: String?
    let isFollowing: Bool
    let reviewerTags: [String]
    let reviewLikeCount: Int
    let reviewRating: Int
    let reviewContent: String
    let isReviewLiked: Bool
    let isProductBookmarked: Bool
    let reviewImageUrls: [String]?
    let createdAt: String
}
