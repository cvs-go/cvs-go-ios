//
//  MyReviewView.swift
//  PyeonHae
//
//  Created by 정건호 on 2023/07/27.
//

import SwiftUI

struct MyReviewView: View {
    @Binding var reviewContent: UserReviewsModel?
    
    var body: some View {
        if let reviewContent = reviewContent {
            VStack(spacing: 0) {
                Spacer().frame(height: 10)
                HStack {
                    HStack(spacing: 2) {
                        Text("작성한 리뷰")
                            .font(.pretendard(.regular, 12))
                            .foregroundColor(.grayscale85)
                        Text("\(reviewContent.totalElements)")
                            .font(.pretendard(.bold, 12))
                            .foregroundColor(.grayscale85)
                        Spacer()
                        HStack(spacing: 6) {
                            Text("최신순")
                                .font(.pretendard(.regular, 12))
                                .foregroundColor(.grayscale85)
                            Image(name: .invertedTriangle)
                        }
                        .frame(width: 64.5, height: 26)
                        .background(Color.grayscale10)
                        .cornerRadius(10)
                    }
                }
                .frame(height: 40)
                .padding(.horizontal,20)
                Spacer().frame(height: 10)
                ScrollView {
                    ForEach(reviewContent.content, id: \.self) { review in
                        myReviewCell(review)
                        Color.grayscale30.opacity(0.5).frame(height: 1)
                            .padding(.bottom, 16)
                    }
                }
            }
        }
    }
    
    private func myReviewCell(_ review: UserReviewDataModel) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 0) {
                ReviewContents(
                    reviewerId: review.reviewerId,
                    rating: review.reviewRating,
                    imageUrls: review.reviewImageUrls,
                    content: review.reviewContent,
                    isReviewLiked: review.isReviewLiked,
                    likeCount: review.reviewLikeCount,
                    likeAction: {
//                        likeAction()
                    },
                    unlikeAction: {
//                        unlikeAction()
                    }
                )
            }
            ReviewProduct(
                imageUrl: review.productImageUrl,
                manufacturer: review.productManufacturer,
                name: review.productName,
                isBookmarked: review.isProductBookmarked,
                bookmarkAction: {
//                    bookmarkAction()
                },
                unBookmarkAction:  {
//                    unBookmarkAction()
                }
            )
        }
    }
}
