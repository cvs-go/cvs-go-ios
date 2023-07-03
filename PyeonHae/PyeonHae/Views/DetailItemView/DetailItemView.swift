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
    @State private var isReviewButtonVisible = false
    
    let selectedProduct: Product?
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                DetailItemViewTopBar
                ScrollView {
                    ItemDetailView(productDetail: searchViewModel.productDetail?.data)
                        .background(
                            GeometryReader { geometry -> Color in
                                let maxY = geometry.frame(in: .global).midY
                                DispatchQueue.main.async {
                                    isReviewButtonVisible = maxY <= 0
                                }
                                return Color.clear
                            }
                        )
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
        }
        .fullScreenCover(isPresented: $reviewViewModel.showWriteView) {
            EditReviewView(
                reviewViewModel: reviewViewModel,
                fixedProduct: selectedProduct
            )
        }
    }
    
    var DetailItemViewTopBar: some View {
        HStack(spacing: 0) {
            Spacer().frame(width: 14)
            Image(name: .arrowLeft)
                .onTapGesture {
                    searchViewModel.showProductDetail = false
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
                                    tags: review.reviewerTags
                                )
                                .padding(.bottom, 10)
                                HStack(spacing: 0) {
                                    Spacer().frame(width: 12)
                                    ReviewContents(
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
