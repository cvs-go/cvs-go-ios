//
//  DetailItemView.swift
//  PyeonHae
//
//  Created by 이주화 on 2023/03/01.
//

import SwiftUI

struct DetailItemView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @ObservedObject var searchViewModel: SearchViewModel
    @ObservedObject var reviewViewModel = ReviewViewModel()
    @State private var isReviewButtonVisible = false
    
    @State private var showUserPage = false
    @State private var selectedReviewerId = -1
    
    @Binding var selectedProduct: Product?
    
    var body: some View {
        if searchViewModel.detailIsLoading {
            LoadingView()
        } else {
            ZStack {
                VStack(alignment: .leading) {
                    DetailItemViewTopBar
                    ScrollView {
                        if let product = searchViewModel.productDetail {
                            ItemDetailView(
                                productDetail: product.data,
                                isHeartMark: product.data.isLiked,
                                isBookMark: product.data.isBookmarked,
                                likeAction: {
                                    searchViewModel.requestProductLike(productID: product.data.productId)
                                },
                                unlikeAction: {
                                    searchViewModel.requestProductUnLike(productID: product.data.productId)
                                },
                                bookmarkAction: {
                                    searchViewModel.requestProductBookmark(productID: product.data.productId)
                                },
                                unBookmarkAction: {
                                    searchViewModel.requestProductUnBookmark(productID: product.data.productId)
                                }
                            )
                            .background(
                                GeometryReader { geometry -> Color in
                                    let maxY = geometry.frame(in: .global).midY
                                    DispatchQueue.main.async {
                                        isReviewButtonVisible = maxY <= 0
                                    }
                                    return Color.clear
                                }
                            )
                        }
                        Rectangle()
                            .frame(height: 14)
                            .foregroundColor(Color.grayscale10)
                        DetailItemReviewsView
                        Rectangle()
                            .frame(height: 30)
                            .foregroundColor(Color.white)
                    }
                }
                VStack {
                    Spacer()
                    Button(action: {
                        reviewViewModel.showWriteView = true
                    }){
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(.red100)
                            Text("리뷰 작성")
                                .font(.pretendard(.bold, 18))
                                .foregroundColor(.white)
                        }
                        .frame(height: 50)
                        .padding(.horizontal, 20)
                        .background(Color.white)
                    }
                    .buttonStyle(.plain)
                }
            }.navigationBarBackButtonHidden()
            .fullScreenCover(isPresented: $reviewViewModel.showWriteView) {
                EditReviewView(
                    reviewViewModel: reviewViewModel,
                    fixedProduct: selectedProduct
                )
            }
            .onAppear {
                // 최근 찾은 상품 저장
                if let product = selectedProduct {
                    if !UserShared.searchedProducts.map({ $0.product }).contains(product) {
                        UserShared.searchedProducts.append(.init(
                            product: product,
                            timestamp: Date().currentTime()
                        ))
                    }
                }
            }
            .onDisappear {
                self.selectedProduct = nil
            }
        }
    }
    
    var DetailItemViewTopBar: some View {
        HStack(spacing: 0) {
            Spacer().frame(width: 14)
            Image(name: .arrowLeft)
                .onTapGesture {
                    self.presentationMode.wrappedValue.dismiss()
                }
            Spacer().frame(width: 18)
            if isReviewButtonVisible {
                Text(searchViewModel.productDetail?.data.productName ?? String())
                    .font(.pretendard(.bold, 18))
                    .foregroundColor(.black)
            }
            Spacer()
        }
        .frame(height: 44)
    }
    
    var DetailItemReviewsView: some View {
        VStack {
            HStack {
                Text("리뷰 \(String(searchViewModel.reviewDatas?.totalElements ?? 0))개")
                    .font(.pretendard(.semiBold, 16))
                    .foregroundColor(.grayscale100)
                Spacer()
                Image(name: .redStar)
                    .resizable()
                    .frame(width: 16, height: 16)
                Text("4.5")
                    .font(.pretendard(.semiBold, 16))
                    .foregroundColor(.grayscale100)
            }
            .padding(.top, 12)
            .padding(.horizontal, 20)
            HStack {
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
            .padding(.horizontal, 20)
            
            if let reviewDatas = searchViewModel.reviewDatas,
               let content = reviewDatas.content {
                if reviewDatas.totalElements == 0 {
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
                } else {
                    VStack(alignment: .leading, spacing: 0) {
                        ForEach(content, id: \.self) { review in
                            Group {
                                ReviewUserInfo(
                                    reviewType: .normal,
                                    profileUrl: review.reviewerProfileImageUrl,
                                    nickname: review.reviewerNickname,
                                    tags: review.reviewerTags,
                                    isMe: review.isMe,
                                    isFollowing: review.isFollowingUser,
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
                                .padding(.bottom, 10)
                                HStack(spacing: 0) {
                                    Spacer().frame(width: 12)
                                    ReviewContents(
                                        reviewerId: review.reviewerId,
                                        rating: review.reviewRating,
                                        imageUrls: review.reviewImages,
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
                            }
                            Color.grayscale30.opacity(0.5).frame(height: 1)
                                .padding(.vertical, 16)
                        }
                    }
                }
            }
        }
    }
}
