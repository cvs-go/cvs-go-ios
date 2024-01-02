//
//  WriteReviews.swift
//  PyeonHae
//
//  Created by 이주화 on 2023/02/08.
//

import SwiftUI

struct WriteReviewsView: View {
    @Binding var userReviews: UserReviewsModel?
    
    var body: some View {
        if let userReviews = userReviews {
            VStack {
                HStack {
                    Text("작성한 리뷰")
                        .font(.pretendard(.semiBold, 20))
                        .foregroundColor(.grayscale100)
                    Text("\(userReviews.totalElements)")
                        .font(.pretendard(.semiBold, 20))
                        .foregroundColor(.red100)
                    Spacer()
                    //                    Image(name: .fillLike)
                    //                    Text("14245명")
                    //                        .font(.pretendard(.semiBold, 12))
                    //                        .foregroundColor(.grayscale50)
                }
                .padding(.horizontal, 20)
                ScrollView {
                    VStack {
                        ForEach(userReviews.content, id: \.self) { review in
                            ReviewCell(review)
                            Color.grayscale30.opacity(0.5).frame(height: 1)
                                .padding(.bottom, 16)
                        }
                    }
                }
            }
            .padding(.top, 14)
            .background(Color.white)
        } else {
            Text("데이터 로드 실패")
        }
    }
    
    private func ReviewCell(_ review: UserReviewDataModel) -> some View {
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
