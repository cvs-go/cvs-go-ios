//
//  ItemDetailView.swift
//  PyeonHae
//
//  Created by 이주화 on 2023/03/01.
//

import SwiftUI
import Kingfisher

struct ItemDetailView: View {
    let productDetail: ProductInfo?
    let productTags: [ProductTagsModel]?
    var isHeartMark: Bool
    var isBookMark: Bool
    let likeAction: () -> Void
    let unlikeAction: () -> Void
    let bookmarkAction: () -> Void
    let unBookmarkAction: () -> Void
    
    @State private var isLikedValue: Bool
    @State private var isBookMarkedValue: Bool
    
    init(
        productDetail: ProductInfo?,
        productTags: [ProductTagsModel]?,
        isHeartMark: Bool,
        isBookMark: Bool,
        likeAction: @escaping () -> Void,
        unlikeAction: @escaping () -> Void,
        bookmarkAction: @escaping () -> Void,
        unBookmarkAction: @escaping () -> Void
    ) {
        self.productDetail = productDetail
        self.productTags = productTags
        self.isHeartMark = isHeartMark
        self.isBookMark = isBookMark
        self.likeAction = likeAction
        self.unlikeAction = unlikeAction
        self.bookmarkAction = bookmarkAction
        self.unBookmarkAction = unBookmarkAction
        
        _isLikedValue = State(initialValue: isHeartMark)
        _isBookMarkedValue = State(initialValue: isBookMark)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .center) {
                Spacer()
                if let url = productDetail?.productImageUrl, let imageUrl = URL(string: url) {
                    KFImage(imageUrl)
                        .resizable()
                        .frame(width: 200, height: 200)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black.opacity(0.05), lineWidth: 1)
                                .frame(width: UIWindow().screen.bounds.width - 40, height: 200)
                        )
                } else {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.black.opacity(0.05), lineWidth: 1)
                        .frame(width: UIWindow().screen.bounds.width - 40, height: 200)
                }
                Spacer()
            }
            Text(productDetail?.manufacturerName ?? String())
                .font(.pretendard(.regular, 12))
                .foregroundColor(.grayscale70)
                .padding(.top, 12)
            HStack {
                Text(productDetail?.productName ?? String())
                    .font(.pretendard(.semiBold, 18))
                    .foregroundColor(.grayscale100)
                Spacer()
                Button(action: {
                    isLikedValue.toggle()
                    isLikedValue ? likeAction() : unlikeAction()
                }){
                    isLikedValue ? Image(name: .heartMarkFill) : Image(name: .heartMark)
                }
                .frame(width: 18, height: 18)
                Button(action: {
                    isBookMarkedValue.toggle()
                    isBookMarkedValue ? bookmarkAction() : unBookmarkAction()
                }){
                    isBookMarkedValue ? Image(name: .bookMarkFill) : Image(name: .bookMark)
                }
                .frame(width: 18, height: 18)
            }
            Text("\(productDetail?.productPrice ?? 0)원")
                .font(.pretendard(.medium, 18))
                .foregroundColor(.grayscale85)
            HStack(spacing: 4) {
                if let event = productDetail?.convenienceStoreEvents {
                    ForEach(event, id: \.self) { event in
                        if let type = event.eventType {
                            if type == "DISCOUNT" {
                                discountLogo(name: event.name, discount: event.discountAmount ?? 0)
                            } else {
                                Image("\(event.name)_\(type)")
                            }
                        } else {
                            Image(event.name)
                        }
                    }
                }
            }
            .padding(.top, 16)
            if let productTags = productTags, !productTags.isEmpty {
                HStack(spacing: 0) {
                    Text("이 제품을 주로 찾는 유저예요.")
                        .font(.pretendard(.regular, 12))
                        .foregroundColor(.grayscale70)
                    Spacer()
                    HStack(spacing: 12) {
                        ForEach(productTags, id: \.self) { tag in
                            HStack(spacing: 2) {
                                Text(tag.name)
                                    .font(.pretendard(.regular, 12))
                                    .foregroundColor(.grayscale85)
                                Text(" \(tag.tagCount)")
                                    .font(.pretendard(.bold, 12))
                                    .foregroundColor(.grayscale85)
                            }
                        }
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .foregroundColor(Color.grayscale20)
                            .padding(.horizontal, -8)
                            .frame(height: 22)
                    )
                }
                .padding(.top, 24)
            }
            Spacer().frame(height: 16)
        }
        .padding(.top, 21)
        .padding(.horizontal, 20)
    }
    
    @ViewBuilder
    private func discountLogo(name: String, discount: Int) -> some View {
        let color = decideColor(name)
        
        HStack(spacing: 2) {
            Image("\(name)")
            ZStack {
                HStack(spacing: 0) {
                    Text("-\(String(discount))원")
                        .foregroundColor(color)
                        .font(.pretendard(.semiBold, 9))
                        .padding(.trailing, 3)
                }
            }
        }
        .overlay(RoundedRectangle(cornerRadius: 10)
            .stroke(color.opacity(0.3), lineWidth: 1)
        )
    }
    
    private func decideColor(_ name: String) -> Color {
        var color: Color = .cuColor
        
        if name == "GS" {
            color = .gsColor
        } else if name == "Emart24" {
            color = .emart24Color
        } else if name == "세븐일레븐" {
            color = .sevenElevenColor
        } else if name == "미니스톱" {
            color = .miniStopColor
        }
        
        return color
    }
}
