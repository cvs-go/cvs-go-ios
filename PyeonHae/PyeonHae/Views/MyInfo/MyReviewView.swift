//
//  MyReviewView.swift
//  PyeonHae
//
//  Created by 정건호 on 2023/07/27.
//

import SwiftUI

struct MyReviewView: View {
    @ObservedObject var myInfoViewModel: MyInfoViewModel
    @Binding var reviewContent: UserReviewsModel?
    @State private var sortClicked = false
    
    var body: some View {
        VStack(spacing: 0) {
            SortView(
                type: .myInfoReview,
                elementCount: reviewContent?.totalElements ?? 0,
                sortBy: $myInfoViewModel.reviewSortBy,
                sortClicked: $sortClicked,
                content: {
                    if let reviewContent = reviewContent {
                        ScrollView {
                            ForEach(reviewContent.content, id: \.self) { review in
                                myReviewCell(review)
                                Color.grayscale30.opacity(0.5).frame(height: 1)
                                    .padding(.bottom, 16)
                            }
                        }
                    }
                },
                searchAction: {
                    myInfoViewModel.requestMyReviewList()
                }
            )
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
                        myInfoViewModel.requestLikeReview(id: review.reviewId)
                    },
                    unlikeAction: {
                        myInfoViewModel.requestUnlikeReview(id: review.reviewId)
                    }
                )
            }
            ReviewProduct(
                imageUrl: review.productImageUrl,
                manufacturer: review.productManufacturer,
                name: review.productName,
                isBookmarked: review.isProductBookmarked,
                bookmarkAction: {
                    myInfoViewModel.requestProductBookmark(productID: review.productId)
                },
                unBookmarkAction:  {
                    myInfoViewModel.requestProductUnBookmark(productID: review.productId)
                }
            )
        }
    }
}
