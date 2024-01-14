//
//  DetailItemView.swift
//  PyeonHae
//
//  Created by 이주화 on 2023/03/01.
//

import SwiftUI

struct DetailItemView: View {
    @ObservedObject var searchViewModel: SearchViewModel
    @ObservedObject var reviewViewModel = ReviewViewModel()
    @State private var titleIsVisiable = false
    
    @State private var showUserPage = false
    @State private var selectedReviewerId = -1
    
    @State private var showFilter = false
    @State private var filterOrSortClicked = false // 필터, 정렬 값 바꼈을 경우
    
    @Binding var selectedProduct: Product?
    @Binding var productList: Products?
    
    init(
        searchViewModel: SearchViewModel,
        selectedProduct: Binding<Product?>,
        productList: Binding<Products?> = .constant(nil)
    ) {
        self.searchViewModel = searchViewModel
        self._selectedProduct = selectedProduct
        self._productList = productList
    }
    
    var body: some View {
        if searchViewModel.detailIsLoading {
            LoadingView()
        } else {
            ZStack {
                VStack(alignment: .leading) {
                    NavigationBar(
                        title: searchViewModel.productDetail?.data.productName ?? String(),
                        isVisiable: $titleIsVisiable
                    )
                    ScrollView {
                        if let product = searchViewModel.productDetail {
                            ItemDetailView(
                                productDetail: product.data,
                                productTags: searchViewModel.productTags,
                                isHeartMark: product.data.isLiked,
                                isBookMark: product.data.isBookmarked,
                                likeAction: {
                                    searchViewModel.requestProductLike(productID: product.data.productId)
                                },
                                unlikeAction: {
                                    searchViewModel.requestProductUnLike(productID: product.data.productId)
                                    // 내정보에서 좋아요 취소 시 리스트에서 제거
                                    if let _ = productList {
                                        productList?.content.removeAll(where: { $0.productId == product.data.productId })
                                        productList?.totalElements -= 1
                                    }
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
                                        titleIsVisiable = maxY <= 0
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
                        reviewViewModel.showEditView = true
                    }){
                        ZStack {
                            RoundedRectangle(cornerRadius: UIDevice().hasNotch ? 10 : 0)
                                .foregroundColor(.red100)
                            Text("리뷰 작성")
                                .font(.pretendard(.bold, 18))
                                .foregroundColor(.white)
                        }
                        .frame(height: 50)
                        .padding(.horizontal, UIDevice().hasNotch ? 20 : 0)
                        .background(Color.white)
                    }
                    .buttonStyle(.plain)
                }
            }
            .fullScreenCover(isPresented: $reviewViewModel.showEditView) {
                EditReviewView(
                    reviewViewModel: reviewViewModel,
                    fixedProduct: selectedProduct
                )
            }
            .onAppear {
                // 최근 찾은 상품 저장
                if let product = selectedProduct {
                    if UserShared.searchedProducts.map({ $0.product.productId }).contains(product.productId) {
                        UserShared.searchedProducts.removeAll(where: { $0.product.productId == product.productId })
                    }
                    UserShared.searchedProducts.append(.init(
                        product: product,
                        timestamp: Date().currentTime()
                    ))
                }
            }
            .onDisappear {
                self.selectedProduct = nil
                self.searchViewModel.initReviewParameters()
            }
            .onChange(of: filterOrSortClicked) { _ in
                if let selectedProduct = selectedProduct {
                    self.searchViewModel.requestReview(productID: selectedProduct.productId)
                } else {
                    self.searchViewModel.requestReview(productID: searchViewModel.productDetail?.data.productId ?? -1)
                }
            }
        }
    }
    
    var DetailItemReviewsView: some View {
        VStack(spacing: 0) {
            HStack {
                Text("리뷰 \(String(searchViewModel.reviewDatas?.totalElements ?? 0))개")
                    .font(.pretendard(.semiBold, 16))
                    .foregroundColor(.grayscale100)
                Spacer()
                if let selectedProduct = selectedProduct {
                    Image(name: .redStar)
                        .resizable()
                        .frame(width: 16, height: 16)
                    Text(selectedProduct.reviewRating)
                        .font(.pretendard(.semiBold, 16))
                        .foregroundColor(.grayscale100)
                }
            }
            .padding(EdgeInsets(top: 12, leading: 20, bottom: 16, trailing: 20))
            ReviewFilterView(
                reviewType: .detail,
                showFilter: $showFilter,
                filterClicked: $filterOrSortClicked,
                tagIds: $searchViewModel.tagIds,
                ratings: $searchViewModel.ratings
            )
            .padding(.bottom, 8)
            ZStack(alignment: .top) {
                HStack(alignment: .top) {
                    Spacer()
                    SortSelectView(
                        sortType: .review,
                        sortBy: $searchViewModel.reviewSortBy,
                        sortClicked: $filterOrSortClicked
                    )
                    Spacer().frame(width: 20)
                }
                .offset(y: -38)
                .zIndex(1)
                .hidden(showFilter)
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
}
