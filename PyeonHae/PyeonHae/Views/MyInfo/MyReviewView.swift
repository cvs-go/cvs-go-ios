//
//  MyReviewView.swift
//  PyeonHae
//
//  Created by 정건호 on 2023/07/27.
//

import SwiftUI

struct MyReviewView: View {
    @ObservedObject var myInfoViewModel: MyInfoViewModel
    @ObservedObject var reviewViewModel = ReviewViewModel()
    @State private var sortClicked = false
    @State private var showToastMessage = false
    
    var body: some View {
        VStack(spacing: 0) {
            SortView(
                type: .myInfoReview,
                elementCount: myInfoViewModel.myReviewData?.totalElements ?? 0,
                sortBy: $myInfoViewModel.reviewSortBy,
                sortClicked: $sortClicked,
                content: {
                    if let reviewContent = myInfoViewModel.myReviewData {
                        ScrollView {
                            ScrollViewReader { proxy in
                                ForEach(reviewContent.content.enumeratedArray(), id: \.element) { index, review in
                                    LazyVStack(alignment: .leading, spacing: 10) {
                                        myReviewCell(review)
                                            .onAppear {
                                                if reviewContent.content.count - 3 == index,
                                                   !myInfoViewModel.reviewLast {
                                                    myInfoViewModel.reviewPage += 1
                                                    myInfoViewModel.requestMoreMyReviewList()
                                                }
                                            }
                                    }
                                    .id(index)
                                }
                                .onChange(of: reviewViewModel.reviewIsModified) { _ in
                                    proxy.scrollTo(0)
                                }
                            }
                        }
                    }
                },
                searchAction: {
                    myInfoViewModel.requestMyReviewList()
                }
            )
        }
        .onChange(of: reviewViewModel.reviewIsModified) { _ in
            myInfoViewModel.requestMyReviewList()
            showToastMessage = true
        }
        .toast(
            message: "리뷰가 수정되었습니다!",
            isShowing: $showToastMessage
        )
    }
    
    private func myReviewCell(_ review: UserReviewDataModel) -> some View {
        VStack {
            HStack(spacing: 0) {
                ReviewContents(
                    reviewViewModel: reviewViewModel,
                    reviewType: .myInfo,
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
                    },
                    modifyProduct: (
                        review.reviewId,
                        review.productImageUrl,
                        review.productManufacturer,
                        review.productName
                    )
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
            Color.grayscale30.opacity(0.5).frame(height: 1)
                .padding(.bottom, 16)
        }
    }
}
