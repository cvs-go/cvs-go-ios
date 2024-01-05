//
//  PopularReview.swift
//  PyeonHae
//
//  Created by 이주화 on 2023/01/26.
//

import SwiftUI

struct PopularReview: View {
    @ObservedObject var homeViewModel: HomeViewModel
    
    var body: some View {
        VStack {
            HStack {
                Spacer().frame(width: 20)
                Text("인기 리뷰")
                    .font(.pretendard(.bold, 18))
                    .foregroundColor(.grayscale100)
                Spacer()
            }
            Spacer().frame(height: 16)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach($homeViewModel.popularReviews, id: \.self) { review in
                        ReviewView(
                            review: review,
                            likeAction: {
                                homeViewModel.requestLikeReview(id: review.reviewId.wrappedValue)
                            },
                            unlikeAction: {
                                homeViewModel.requestUnlikeReview(id: review.reviewId.wrappedValue)
                            },
                            bookmarkAction: {
                                homeViewModel.requestProductBookmark(productID: review.productId.wrappedValue)
                            },
                            unBookmarkAction: {
                                homeViewModel.requestProductUnBookmark(productID: review.productId.wrappedValue)
                            }
                        )
                        .frame(width: UIWindow().screen.bounds.width - 75)
                    }
                }
                .padding(.trailing, 20)
            }
        }
        .padding(.vertical, 16)
        .background(Color.white)
    }
}
