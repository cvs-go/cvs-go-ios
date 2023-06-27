//
//  ReviewHome.swift
//  PyeonHae
//
//  Created by 정건호 on 2023/02/02.
//

import SwiftUI

struct ReviewHome: View {
    @ObservedObject var reviewViewModel = ReviewViewModel()
    
    @State private var tabItems = ReviewTapType.allCases.map { $0.rawValue }
    @State private var selectedElements: [String] = []
    @State private var showFilter = false
    @State var selectedSortOptionIndex = 0
    
    // 임시 데이터
    let filterDatas: [FilterData] = [
        FilterData(category: "편의점", elements: ["CU", "GS25", "7일레븐", "Emart24", "미니스톱"]),
        FilterData(category: "제품", elements: ["간편식사", "즉석요리", "과자&빵", "아이스크림", "신선식품", "유제품", "음료", "기타"]),
        FilterData(category: "유저", elements: ["맵부심", "맵찔이", "초코러버", "비건", "다이어터", "대식가", "소식가", "기타"]),
        FilterData(category: "이벤트", elements: ["1+1", "2+1", "3+1", "증정"]),
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            navigationBar
            TopTabBar(
                tabItems: tabItems,
                contents: [
                    AnyView(allReviewTab()),
                    AnyView(followReviewTab())
                ]
            )
        }
        .fullScreenCover(isPresented: $reviewViewModel.showWriteView) {
            EditReviewView(reviewViewModel: reviewViewModel)
        }
        .toast(
            message: "리뷰 작성에 성공했습니다!",
            isShowing: $reviewViewModel.showToastMessage
        )
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
        ScrollView {
            VStack(spacing: 0) {
                Spacer().frame(height: 10)
                
                // TODO: 리뷰 필터 뷰 수정하기
//                FilterView(
//                    filterDatas: filterDatas,
//                    showFilter: $showFilter,
//                    selectedElements: $selectedElements
//                )
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
            ForEach(reviewViewModel.reviewList, id: \.self) { review in
                VStack(alignment: .leading, spacing: 10) {
                    ReviewUserInfo(
                        reviewType: .normal,
                        profileUrl: review.reviewerProfileImageUrl,
                        nickname: review.reviewerNickname,
                        tags: review.reviewerTags
                    )
                    HStack(spacing: 0) {
                        Spacer().frame(width: 12)
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
                        name: review.productName
                    )
                }
                .padding(.horizontal, 19)
                Color.grayscale30.opacity(0.5).frame(height: 1)
                    .padding(.bottom, 16)
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
