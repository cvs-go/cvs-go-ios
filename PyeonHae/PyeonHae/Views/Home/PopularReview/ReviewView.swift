//
//  ReviewView.swift
//  PyeonHae
//
//  Created by 이주화 on 2023/02/08.
//

import SwiftUI

struct ReviewView: View {
    @Binding var review: ReviewDataModel
    
    let likeAction: () -> Void
    let unlikeAction: () -> Void
    let bookmarkAction: () -> Void
    let unBookmarkAction: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Group {
                ReviewUserInfo(
                    reviewType: .popular,
                    profileUrl: review.reviewerProfileImageUrl,
                    nickname: review.reviewerNickname,
                    tags: review.reviewerTags,
                    isMe: review.reviewerId == UserShared.userId,
                    isFollowing: review.isFollowing,
                    reviewerId: review.reviewerId
                )
            }
            HStack(spacing: 0) {
                ReviewContents(
                    rating: review.reviewRating,
                    imageUrls: review.reviewImageUrls,
                    content: review.reviewContent,
                    isReviewLiked: review.isReviewLiked,
                    likeCount: review.reviewLikeCount,
                    likeAction: {
                        likeAction()
                    },
                    unlikeAction: {
                        unlikeAction()
                    }
                )
            }
            ReviewProduct(
                imageUrl: review.productImageUrl,
                manufacturer: review.productManufacturer,
                name: review.productName,
                isBookmarked: review.isProductBookmarked,
                bookmarkAction: {
                    bookmarkAction()
                },
                unBookmarkAction:  {
                    unBookmarkAction()
                }
            )
        }
    }
}
