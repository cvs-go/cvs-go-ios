//
//  ReviewHome.swift
//  PyeonHae
//
//  Created by 정건호 on 2023/02/02.
//

import SwiftUI

struct ReviewHome: View {
    @ObservedObject var reviewViewModel = ReviewViewModel()
    
    @State private var reviewLoaded = false
    
    @State private var tabItems = ReviewTapType.allCases.map { $0.rawValue }
    @State private var selectedElements: [String] = []
    @State private var showFilter = false
    @State private var filterOrSortClicked = false
    @State private var searchAgain = false
    
    @State private var showUserPage = false
    @State private var selectedReviewerId = -1
    
    private let deviceBounds = UIApplication.keyWindow?.screen.bounds
    
    var body: some View {
        VStack(spacing: 0) {
            navigationBar
            TopTabBar(
                tabItems: tabItems,
                contents: [
                    AnyView(allReviewTab()),
                    AnyView(followReviewTab())
                ],
                type: .review
            )
        }
        .fullScreenCover(isPresented: $reviewViewModel.showEditView) {
            EditReviewView(
                reviewViewModel: reviewViewModel,
                fixedProduct: nil
            )
        }
        .toast(
            message: "리뷰 작성에 성공했습니다!",
            isShowing: $reviewViewModel.showToastMessage
        )
        .task {
            if !reviewLoaded {
                reviewViewModel.isLoading = true
                reviewViewModel.requestReviews()
                self.reviewLoaded = true
            }
        }
        .onChange(of: searchAgain) { _ in
            self.reviewViewModel.isLoading = true
            self.reviewViewModel.requestReviews()
        }
        .navigationDestination(isPresented: $showUserPage) {
            UserPageView(
                reviewViewModel: reviewViewModel,
                selectedReviewerId: $selectedReviewerId
            )
        }
    }
    
    @ViewBuilder
    private var navigationBar: some View {
        VStack {
            HStack {
                Spacer().frame(width: 20)
                Text("리뷰")
                    .font(.pretendard(.bold, 20))
                    .foregroundColor(.grayscale100)
                Spacer()
                Image(name: .addSquare)
                    .onTapGesture {
                        reviewViewModel.showEditView = true
                    }
                Spacer().frame(width: 18)
            }
        }
        .frame(height: 44)
    }
    
    @ViewBuilder
    private func allReviewTab() -> some View {
        ReviewFilterView(
            showFilter: $showFilter,
            filterClicked: $filterOrSortClicked,
            categoryIds: $reviewViewModel.categoryIds,
            tagIds: $reviewViewModel.tagIds,
            ratings: $reviewViewModel.ratings
        )
        .padding(.top, 10)
        SortView(
            type: .review,
            elementCount: reviewViewModel.latestReviewCount,
            sortBy: $reviewViewModel.sortBy,
            sortClicked: $filterOrSortClicked,
            content: {
                GeometryReader { geometry in
                    if reviewViewModel.isLoading {
                        LoadingView()
                            .frame(width: geometry.size.width)
                            .frame(minHeight: geometry.size.height)
                    } else {
                        if reviewViewModel.reviewList.isEmpty {
                            VStack {
                                Spacer().frame(height: 53)
                                Image(name: .emptyReviewImage)
                                Spacer().frame(height: 12)
                                Text("앗! 등록된 리뷰가 없어요")
                                    .font(.pretendard(.semiBold, 16))
                                    .foregroundColor(.grayscale85)
                                Spacer().frame(height: 2)
                                Text("첫 번째로 리뷰를 등록해보세요.")
                                    .font(.pretendard(.light, 14))
                                    .foregroundColor(.grayscale70)
                                Spacer().frame(height: 53)
                            }
                            .frame(width: geometry.size.width)
                            .frame(minHeight: geometry.size.height)
                        }
                    }
                }
                DefaultList {
                    ForEach(reviewViewModel.reviewList.enumeratedArray(), id: \.element) { index, review in
                        VStack {
                            ReviewUserInfo(
                                reviewType: .normal,
                                profileUrl: review.reviewerProfileImageUrl,
                                nickname: review.reviewerNickname,
                                tags: review.reviewerTags,
                                isMe: review.reviewerId == UserShared.userId,
                                isFollowing: review.isFollowing,
                                followAction: {
                                    reviewViewModel.requestFollow(userId: review.reviewerId)
                                },
                                unfollowAction: {
                                    reviewViewModel.requestUnfollow(userId: review.reviewerId)
                                },
                                reviewerId: review.reviewerId,
                                showUserPage: $showUserPage,
                                selectedReviewerId: $selectedReviewerId
                            )
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
                        .onAppear {
                            if reviewViewModel.reviewList.count - 3 == index,
                               !reviewViewModel.last {
                                reviewViewModel.page += 1
                                reviewViewModel.requestMoreReviews()
                            }
                        }
                    }
                }
                .simultaneousGesture(DragGesture().onChanged { _ in
                    withAnimation(.easeInOut(duration: 0.3)) {
                        self.showFilter = false
                    }
                })
            },
            searchAction: {
                reviewViewModel.requestReviews()
            }
        )
    }
}

private func followReviewTab() -> some View {
    VStack {
        Text("팔로우 탭")
        Spacer()
    }
}
