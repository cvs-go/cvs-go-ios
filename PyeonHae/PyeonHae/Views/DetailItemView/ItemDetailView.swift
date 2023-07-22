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
        isHeartMark: Bool,
        isBookMark: Bool,
        likeAction: @escaping () -> Void,
        unlikeAction: @escaping () -> Void,
        bookmarkAction: @escaping () -> Void,
        unBookmarkAction: @escaping () -> Void
    ) {
        self.productDetail = productDetail
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
                        .stroke(Color.grayscale10, lineWidth: 1)
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
                            Image("\(event.name)_\(type)")
                        } else {
                            Image(event.name)
                        }
                    }
                }
            }
            .padding(.top, 16)
            HStack {
                Text("이 제품을 주로 찾는 유저예요.")
                    .font(.pretendard(.regular, 12))
                    .foregroundColor(.grayscale70)
                    .padding(.trailing, 15)
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                    HStack {
                        Text("맵찔이 11")
                            .font(.pretendard(.regular, 12))
                            .foregroundColor(.grayscale85)
                        Spacer()
                        Text("초코킬러 9")
                            .font(.pretendard(.regular, 12))
                            .foregroundColor(.grayscale85)
                        Spacer()
                        Text("소식가 6")
                            .font(.pretendard(.regular, 12))
                            .foregroundColor(.grayscale85)
                    }
                    .padding(.vertical, 4)
                    .padding(.horizontal, 8)
                }
                .foregroundColor(Color.grayscale20)
            }
            .padding(.top, 26)
        }
        .padding(.top, 21)
        .padding(.horizontal, 20)
        .onAppear {
            // 최근 찾은 상품 저장
            if let productId = productDetail?.productId,
               let productImageurl = productDetail?.productImageUrl {
                if !UserShared.searchedProducts.map({ $0.productId }).contains(productId) {
                    UserShared.searchedProducts.append(.init(
                        timestamp: Date().currentTime(),
                        productId: productId,
                        productImageUrl: productImageurl
                    ))
                }
            }
        }
    }
}
