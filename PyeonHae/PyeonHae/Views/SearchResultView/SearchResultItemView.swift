//
//  SearchResultItemView.swift
//  PyeonHae
//
//  Created by 이주화 on 2023/02/21.
//

import SwiftUI
import Kingfisher

struct SearchResultItemView: View {
    @Binding var selectedProduct: Product?
    var isHeartMark: Bool
    var isBookMark: Bool
    let product: Product
    let productViewType: ProductViewType
    let likeAction: () -> Void
    let unlikeAction: () -> Void
    let bookmarkAction: () -> Void
    let unBookmarkAction: () -> Void
    
    @State private var isLikedValue: Bool
    @State private var isBookMarkedValue: Bool
    
    init(
        selectedProduct: Binding<Product?>,
        isHeartMark: Bool,
        isBookMark: Bool,
        product: Product,
        productViewType: ProductViewType,
        likeAction: @escaping () -> Void,
        unlikeAction: @escaping () -> Void,
        bookmarkAction: @escaping () -> Void,
        unBookmarkAction: @escaping () -> Void
    ) {
        self._selectedProduct = selectedProduct
        self.isHeartMark = isHeartMark
        self.isBookMark = isBookMark
        self.product = product
        self.productViewType = productViewType
        self.likeAction = likeAction
        self.unlikeAction = unlikeAction
        self.bookmarkAction = bookmarkAction
        self.unBookmarkAction = unBookmarkAction
        
        _isLikedValue = State(initialValue: isHeartMark)
        _isBookMarkedValue = State(initialValue: isBookMark)
    }
    
    var body: some View {
        VStack {
            HStack {
                ZStack {
                    if let url = product.productImageUrl, let imageUrl = URL(string: url) {
                        KFImage(imageUrl)
                            .resizable()
                            .frame(width: 120, height: 120)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.grayscale30, lineWidth: 1)
                            )
                            .frame(width: 120, height: 120)
                    } else {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.grayscale30, lineWidth: 1)
                            .frame(width: 120, height: 120)
                    }
                }
                .frame(width: 120, height: 120)
                VStack(alignment: .leading, spacing: 0) {
                    Text(product.manufacturerName)
                        .font(.pretendard(.regular, 12))
                        .foregroundColor(.grayscale70)
                    HStack {
                        Text(product.productName)
                            .font(.pretendard(.semiBold, 16))
                            .foregroundColor(.grayscale100)
                        Spacer()
                        Group {
                            Image(name: isLikedValue ? .heartMarkFill : .heartMark)
                                .onTapGesture {
                                    isLikedValue.toggle()
                                    isLikedValue ? likeAction() : unlikeAction()
                                }
                            Image(name: isBookMarkedValue ? .bookMarkFill : .bookMark)
                                .onTapGesture {
                                    isBookMarkedValue.toggle()
                                    isBookMarkedValue ? bookmarkAction() : unBookmarkAction()
                                }
//                            Button(action: {

//                            }){
//                                isLikedValue ? Image(name: .heartMarkFill) : Image(name: .heartMark)
//                            }
//                            Button(action: {
//                                isBookMarkedValue.toggle()
//                                isBookMarkedValue ? bookmarkAction() : unBookmarkAction()
//                            }){
//                                isBookMarkedValue ? Image(name: .bookMarkFill) : Image(name: .bookMark)
//                            }
                        }
                        .hidden(productViewType == .review ? true : false)
                    }
                    .padding(.bottom, 2)
                    Text("\(product.productPrice)원")
                        .font(.pretendard(.medium, 16))
                        .foregroundColor(.grayscale85)
                        .padding(.bottom, 8)
                    HStack {
                        Image(name: .redStar)
                        Text(product.reviewRating)
                            .font(.pretendard(.semiBold, 14))
                            .foregroundColor(.grayscale100)
                        Text("|")
                            .font(.pretendard(.semiBold, 14))
                            .foregroundColor(.grayscale30)
                        Text("\(product.reviewCount)개의 리뷰")
                            .font(.pretendard(.regular, 14))
                            .foregroundColor(.grayscale70)
                    }
                    .padding(.bottom, 8)
                    HStack(spacing: 4) {
                        ForEach(product.convenienceStoreEvents, id: \.self) { event in
                            if let type = event.eventType {
                                Image("\(event.name)_\(type)")
                            } else {
                                Image(event.name)
                            }
                        }
                    }
                }
                .padding(.leading, 15)
            }
        }
        .padding(.horizontal,20)
        .onTapGesture {
            selectedProduct = product
        }
    }
}

enum ProductViewType {
    case review
    case search
}
