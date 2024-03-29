//
//  ReviewTextCell.swift
//  PyeonHae
//
//  Created by 이주화 on 2023/03/01.
//

import SwiftUI
import Kingfisher
import ExpandableText

struct ReviewContents: View {
    @ObservedObject var reviewViewModel: ReviewViewModel
    let reviewType: ReviewType
    let reviewerId: Int
    let rating: Int
    let imageUrls: [String]?
    let content: String
    let isReviewLiked: Bool
    let likeCount: Int
    let likeAction: () -> Void
    let unlikeAction: () -> Void
    let modifyProduct: (Int, String?, String, String)? // reviewId, productImageUrl, productManufacturer, productName
    
    @State private var isReviewLikedValue: Bool
    @State private var likeCountValue: Int
    
    @State private var showImageDetail = false
    @State private var detailImageUrl = String()
    
    // 리뷰 삭제 및 수정 변수
    @State private var showActionSheet = false
    @State private var showDeleteAlert = false
    @State private var showEditView = false
    
    init(
        reviewViewModel: ReviewViewModel? = nil,
        reviewType: ReviewType = .normal,
        reviewerId: Int,
        rating: Int,
        imageUrls: [String]?,
        content: String,
        isReviewLiked: Bool,
        likeCount: Int,
        likeAction: @escaping () -> Void,
        unlikeAction: @escaping () -> Void,
        modifyProduct: (Int, String?, String, String)? = nil
    ) {
        self.reviewViewModel = reviewViewModel ?? ReviewViewModel.init()
        self.reviewType = reviewType
        self.reviewerId = reviewerId
        self.rating = rating
        self.imageUrls = imageUrls
        self.content = content
        self.isReviewLiked = isReviewLiked
        self.likeCount = likeCount
        self.likeAction = likeAction
        self.unlikeAction = unlikeAction
        self.modifyProduct = modifyProduct
        
        _isReviewLikedValue = State(initialValue: isReviewLiked)
        _likeCountValue = State(initialValue: likeCount)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack(spacing: 0) {
                ForEach(1..<6) { index in
                    Image(name: rating >= index ? .yellowStar : .emptyStar)
                }
                if reviewerId == UserShared.userId, reviewType == .myInfo {
                    Spacer()
                    Image(name: .more)
                        .onTapGesture {
                            showActionSheet = true
                        }
                }
            }
            .padding(.horizontal, 24)
            if let imageUrls = imageUrls, reviewType != .popular {
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
            if reviewType == .popular {
                VStack(alignment: .leading) {
                    Text(content)
                        .lineLimit(2)
                        .font(.pretendard(.regular, 14))
                        .foregroundColor(.grayscale85)
                        .padding(.horizontal, 24)
                        .multilineTextAlignment(.leading)
                    Spacer()
                }
                .frame(height: 42)
            } else {
                ExpandableText(text: content)
                    .lineLimit(2)
                    .font(.pretendard(.regular, 14))
                    .foregroundColor(.grayscale85)
                    .expandButton(TextSet(text: "더보기", font: .pretendard(.regular, 14), color: .grayscale50))
                    .expandAnimation(.easeOut)
                    .padding(.vertical, 3)
                    .padding(.horizontal, 24)
            }
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
        .confirmationDialog(String(), isPresented: $showActionSheet) {
            Button("수정") {
                showEditView = true
            }
            Button("삭제", role: .destructive) {
                showDeleteAlert = true
            }
            Button("닫기", role: .cancel) {}
        }
        .fullScreenCover(isPresented: $showEditView) {
            EditReviewView(
                type: .modify,
                reviewViewModel: reviewViewModel,
                fixedProduct: nil,
                modifyProduct: modifyProduct,
                writtenContent: content,
                reviewImageUrls: imageUrls,
                givenRating: rating - 1
            )
        }
        .showDestructiveAlert(
            message: "정말로 삭제하시겠습니까?",
            secondaryButtonText: "삭제",
            showAlert: $showDeleteAlert,
            destructiveAction: {
                if let modifyProduct = modifyProduct {
                    reviewViewModel.requestDeleteReview(reviewID: modifyProduct.0)
                }
            }
        )
    }
}
