//
//  ProductReviewsModel.swift
//  PyeonHae
//
//  Created by 정건호 on 2023/06/25.
//

import Foundation

struct ProductReviewsModel: Codable {
    let timestamp: String
    let data: ReviewDatas
}

struct ReviewDatas: Codable {
    var content: [ReviewContent]
    let pageable: Pageable
    let totalElements: Int
    let totalPages: Int
    var last: Bool
    let size: Int
    let number: Int
    let sort: ReviewSort
    let numberOfElements: Int
    let first: Bool
    let empty: Bool
}

struct ReviewContent: Codable, Hashable {
    let reviewId: Int
    let reviewerId: Int
    let reviewerNickname: String
    let reviewerProfileImageUrl: String?
    let isFollowingUser: Bool
    let isMe: Bool
    let reviewContent: String
    let reviewRating: Int
    let isReviewLiked: Bool
    let reviewLikeCount: Int
    let reviewerTags: [String]
    let reviewImages: [String]?
    let createdAt: String
}

struct Pageable: Codable {
    let sort: ReviewSort
    let offset: Int
    let pageNumber: Int
    let pageSize: Int
    let paged: Bool
    let unpaged: Bool
}

struct ReviewSort: Codable {
    let empty: Bool
    let sorted: Bool
    let unsorted: Bool
}
