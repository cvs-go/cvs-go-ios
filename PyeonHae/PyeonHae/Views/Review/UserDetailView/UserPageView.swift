//
//  UserPageView.swift
//  PyeonHae
//
//  Created by 이주화 on 2023/02/08.
//

import SwiftUI

struct UserPageView: View {
    @ObservedObject var reviewViewModel: ReviewViewModel
    @State private var sortClicked = false
    @Binding var selectedReviewerId: Int
    
    var body: some View {
        GeometryReader { geometry in
            if reviewViewModel.userInfoLoading {
                LoadingView()
                    .frame(width: geometry.size.width, height: geometry.size.height)
            } else {
                VStack {
                    NavigationBar(title: "회원 정보")
                    ScrollView {
                        UserInfoView(
                            userInfo: reviewViewModel.userInfo,
                            userInfoType: selectedReviewerId == UserShared.userId ? .me : .other,
                            tagMatchPercentage: reviewViewModel.tagMatchPercentage
                        )
                        Color.grayscale10.frame(height: 14)
                        if let userReviews = reviewViewModel.userReviews {
                            HStack {
                                Spacer().frame(width: 20)
                                Text("작성한 리뷰")
                                    .font(.pretendard(.semiBold, 20))
                                    .foregroundColor(.grayscale100)
                                Text("\(userReviews.totalElements)")
                                    .font(.pretendard(.semiBold, 20))
                                    .foregroundColor(.red100)
                                Spacer()
                            }
                            SortView(
                                type: .userPage,
                                elementCount: 0,
                                sortBy: $reviewViewModel.sortBy,
                                sortClicked: $sortClicked,
                                content: {
                                    VStack {
                                        ForEach(userReviews.content.enumeratedArray(), id: \.element) { index, review in
                                            LazyVStack {
                                                ReviewCell(review)
                                                    .onAppear {
                                                        if userReviews.content.count - 3 == index,
                                                           !reviewViewModel.userLast {
                                                            reviewViewModel.userPage += 1
                                                            reviewViewModel.requestMoreUserReviewList(userId: selectedReviewerId)
                                                        }
                                                    }
                                            }
                                        }
                                    }
                                },
                                searchAction: {
                                    self.reviewViewModel.requestUserReviewList(userId: selectedReviewerId)
                                }
                            )
                        }
                    }
                }
            }
        }
        .onAppear {
            reviewViewModel.userInfoLoading = true
            reviewViewModel.requestSelectedUserInfo(userId: selectedReviewerId)
            reviewViewModel.requestUserReviewList(userId: selectedReviewerId)
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
                        reviewViewModel.requestLikeReview(id: review.reviewId)
                    },
                    unlikeAction: {
                        reviewViewModel.requestUnlikeReview(id: review.reviewId)
                    }
                )
            }
            ReviewProduct(
                imageUrl: review.productImageUrl,
                manufacturer: review.productManufacturer,
                name: review.productName,
                isBookmarked: review.isProductBookmarked,
                bookmarkAction: {
                    reviewViewModel.requestProductBookmark(productID: review.productId)
                },
                unBookmarkAction:  {
                    reviewViewModel.requestProductUnBookmark(productID: review.productId)
                }
            )
            Color.grayscale30.opacity(0.5).frame(height: 1)
                .padding(.bottom, 16)
        }
    }
}
