//
//  MyBookmarkView.swift
//  PyeonHae
//
//  Created by 정건호 on 2023/07/27.
//

import SwiftUI

struct MyBookmarkView: View {
    @ObservedObject var myInfoViewModel: MyInfoViewModel
    @Binding var selectedProduct: Product?
    @Binding var showProductDetail: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer().frame(height: 12)
            HStack {
                HStack(spacing: 2) {
                    Text("북마크한 제품")
                        .font(.pretendard(.regular, 12))
                        .foregroundColor(.grayscale85)
                    Text("\(myInfoViewModel.myBookmarkData?.totalElements ?? 0)개")
                        .font(.pretendard(.bold, 12))
                        .foregroundColor(.grayscale85)
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
            }
            .frame(height: 40)
        }
        .padding(.horizontal,20)
        if let myBookmarkData = myInfoViewModel.myBookmarkData {
            ScrollView {
                ForEach(myBookmarkData.content, id: \.self) { product in
                    VStack {
                        SearchResultItemView(
                            selectedProduct: $selectedProduct,
                            isHeartMark: product.isLiked,
                            isBookMark: product.isBookmarked,
                            product: product,
                            productViewType: .search,
                            likeAction: {
                                myInfoViewModel.requestProductLike(productID: product.productId)
                            },
                            unlikeAction: {
                                myInfoViewModel.requestProductUnlike(productID: product.productId)
                            },
                            bookmarkAction: {
                                myInfoViewModel.requestProductBookmark(productID: product.productId)
                            },
                            unBookmarkAction: {
                                myInfoViewModel.requestProductUnBookmark(productID: product.productId)
                                myInfoViewModel.myBookmarkData?.content.removeAll(where: { $0.productId == product.productId })
                                myInfoViewModel.myBookmarkData?.totalElements -= 1
                            }
                        )
                    }
                    .padding(.vertical, 10)
                }
            }
        }
    }
}
