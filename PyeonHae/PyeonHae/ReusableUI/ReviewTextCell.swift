//
//  ReviewTextCell.swift
//  PyeonHae
//
//  Created by 이주화 on 2023/03/01.
//

import SwiftUI
import Kingfisher

struct ReviewContents: View {
    let rating: Int
    let imageUrls: [String]?
    let content: String
    let isReviewLiked: Bool
    let likeCount: Int
    let likeAction: () -> Void
    let unlikeAction: () -> Void
    
    @State private var isReviewLikedValue: Bool
    @State private var likeCountValue: Int
    
    @State private var showImageDetail = false
    @State private var detailImageUrl = String()
    
    init(
        rating: Int,
        imageUrls: [String]?,
        content: String,
        isReviewLiked: Bool,
        likeCount: Int,
        likeAction: @escaping () -> Void,
        unlikeAction: @escaping () -> Void
    ) {
        self.rating = rating
        self.imageUrls = imageUrls
        self.content = content
        self.isReviewLiked = isReviewLiked
        self.likeCount = likeCount
        self.likeAction = likeAction
        self.unlikeAction = unlikeAction
        
        _isReviewLikedValue = State(initialValue: isReviewLiked)
        _likeCountValue = State(initialValue: likeCount)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack(spacing: 0) {
                Spacer().frame(width: 24)
                ForEach(0..<5) { index in
                    Image(name: rating >= index ? .yellowStar : .emptyStar)
                }
            }
            if let imageUrls = imageUrls {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        Spacer().frame(width: 24)
                        ForEach(imageUrls, id: \.self) { imageUrl in
                            if let url = URL(string: imageUrl) {
                                KFImage(url)
                                    .resizable()
                                    .frame(width: 120, height: 120)
                                    .cornerRadius(10)
                                    .onTapGesture {
                                        self.detailImageUrl = imageUrl
                                        self.showImageDetail = true
                                    }
                            }
                        }
                    }
                }
            }
            Text(content)
                .lineLimit(2)
                .font(.pretendard(.regular, 14))
                .foregroundColor(.grayscale85)
                .padding(.vertical, 3)
                .padding(.horizontal, 24)
            HStack {
                Spacer().frame(width: 24)
                HStack(spacing: 2) {
                    Image(name: isReviewLikedValue ? .fillLike : .like)
                    Text(String(likeCountValue))
                        .font(.pretendard(.semiBold, 12))
                        .foregroundColor(.grayscale85)
                }
                .onTapGesture {
                    isReviewLikedValue.toggle()
                    if isReviewLikedValue {
                        likeAction()
                        likeCountValue += 1
                    } else {
                        unlikeAction()
                        likeCountValue -= 1
                    }
                }
                .padding(EdgeInsets(top: 4, leading: 12, bottom: 4, trailing: 12))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.grayscale30)
                )
            }
        }
        .fullScreenCover(isPresented: $showImageDetail) {
            ImageDetailView(
                imageUrl: self.$detailImageUrl,
                dismissAction: {
                    self.showImageDetail = false
                }
            )
        }
    }
}
