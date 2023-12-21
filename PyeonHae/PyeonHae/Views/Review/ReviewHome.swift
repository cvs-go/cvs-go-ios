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
    @State private var filterClicked = false
    @State var selectedSortOptionIndex = 0
    
    @State private var showUserPage = false
    @State private var selectedReviewerId = -1
    
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
            NavigationLink(
                destination: UserPageView(
                    reviewViewModel: reviewViewModel,
                    selectedReviewerId: $selectedReviewerId
                ).navigationBarHidden(true),
                isActive: $showUserPage)
            {
                EmptyView()
            }
        }
        .fullScreenCover(isPresented: $reviewViewModel.showWriteView) {
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
                reviewViewModel.requestReviewList()
                self.reviewLoaded = true
            }
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
                        reviewViewModel.showWriteView = true
                    }
                Spacer().frame(width: 18)
            }
        }
        .frame(height: 44)
    }
    
    @ViewBuilder
    private func allReviewTab() -> some View {
        VStack(spacing: 0) {
            Spacer().frame(height: 10)
            ReviewFilterView(
                showFilter: $showFilter,
                filterClicked: $filterClicked,
                categoryIds: $reviewViewModel.categoryIds,
                tagIds: $reviewViewModel.tagIds,
                ratings: $reviewViewModel.ratings
            )
            HStack {
                Spacer().frame(width: 20)
                Text("새로운 리뷰 \(reviewViewModel.latestReviewCount)개")
                    .font(.pretendard(.regular, 12))
                    .foregroundColor(.grayscale85)
                Spacer()
                SortSelectView(selectedOptionIndex: $selectedSortOptionIndex)
                Spacer().frame(width: 20)
            }
            .frame(height: 40)
        }
        GeometryReader { geometry in
            ScrollView {
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
                            Spacer().frame(height: 53)
                        }
                        .frame(width: geometry.size.width)
                        .frame(minHeight: geometry.size.height)
                    } else {
                        ForEach(reviewViewModel.reviewList, id: \.self) { review in
                            VStack(alignment: .leading) {
                                Group {
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
                                }
                                HStack(spacing: 0) {
                                    ReviewContents(
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
                            }
                            Color.grayscale30.opacity(0.5).frame(height: 1)
                                .padding(.bottom, 16)
                        }
                    }
                }
            }
            .simultaneousGesture(DragGesture().onChanged { _ in
                withAnimation(.easeInOut(duration: 0.3)) {
                    self.showFilter = false
                }
            })
            .refreshable {
                reviewViewModel.requestReviewList()
            }
            .onChange(of: filterClicked) { _ in
                reviewViewModel.isLoading = true
                reviewViewModel.requestReviewList()
            }
        }
    }
    
    private func followReviewTab() -> some View {
        VStack {
            Text("팔로우 탭")
            Spacer()
        }
    }
}
