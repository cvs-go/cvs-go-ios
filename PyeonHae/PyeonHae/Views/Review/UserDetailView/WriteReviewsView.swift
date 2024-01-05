//
//  WriteReviews.swift
//  PyeonHae
//
//  Created by 이주화 on 2023/02/08.
//

import SwiftUI

struct WriteReviewsView: View {
    @ObservedObject var reviewViewModel: ReviewViewModel
    @Binding var selectedReviewerId: Int
    @State private var showFilter = false
    @State private var filterOrSortClicked = false
    
    var body: some View {
        if let userReviews = reviewViewModel.userReviews {
            VStack {
                VStack(alignment: .leading) {
                    HStack {
                        Text("작성한 리뷰")
                            .font(.pretendard(.semiBold, 20))
                            .foregroundColor(.grayscale100)
                        Text("\(userReviews.totalElements)")
                            .font(.pretendard(.semiBold, 20))
                            .foregroundColor(.red100)
                        Spacer()
                    }
                    HStack(spacing: 2) {
                        Image(name: .fillLike)
                            .renderingMode(.template)
                            .foregroundColor(.grayscale70)
                        Text("14245명에게 도움을 줬어요.")
                            .font(.pretendard(.semiBold, 12))
                            .foregroundColor(.grayscale50)
                        Spacer()
                    }
                }
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 12, trailing: 20))
                ZStack(alignment: .top) {
                    HStack(alignment: .top) {
                        Spacer()
                        SortSelectView(
                            sortType: .review,
                            sortBy: $reviewViewModel.sortBy,
                            sortClicked: $filterOrSortClicked
                        )
                        Spacer().frame(width: 20)
                    }
                    .offset(y: -40)
                    .zIndex(1)
                    .hidden(showFilter)
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
            .onChange(of: filterOrSortClicked) { _ in
                self.reviewViewModel.requestUserReviewList(userId: selectedReviewerId)
            }
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
