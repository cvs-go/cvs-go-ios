//
//  DetailItemReviewsView.swift
//  PyeonHae
//
//  Created by 이주화 on 2023/03/01.
//

import SwiftUI

struct DetailItemReviewsView: View {
    let reviewDatas: ReviewDatas?
    
    var body: some View {
        VStack {
            HStack {
                Text("리뷰 \(String(reviewDatas?.totalElements ?? 0))개")
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
            
            if let reviewDatas = reviewDatas,
               let content = reviewDatas.content {
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
                                    likeCount: review.reviewLikeCount
                                )
                            }
                        }
                        .padding(.horizontal, 20)
                        
                        Color.grayscale30.opacity(0.5).frame(height: 1)
                            .padding(.vertical, 16)
                    }
                }
            }
            
//            ForEach(0..<10) { _ in
//                VStack {
//                    ReviewUserInfo(
//                        reviewType: .normal,
//                        profileUrl: reviewDatas.p
//                    )
//
//                }
//                .padding(.horizontal, 20)
//                Color.grayscale30.opacity(0.5).frame(height: 1)
//                    .padding(.bottom, 16)
//            }
        }
        
    }
}
