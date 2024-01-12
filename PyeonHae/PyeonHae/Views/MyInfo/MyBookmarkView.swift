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
    @State private var sortClicked = false
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer().frame(height: 12)
            ZStack(alignment: .top) {
                HStack(alignment: .top, spacing: 2) {
                    Text("북마크한 제품")
                        .font(.pretendard(.regular, 12))
                        .foregroundColor(.grayscale85)
                        .padding(.top, 6)
                    Text("\(myInfoViewModel.myBookmarkData?.totalElements ?? 0)개")
                        .font(.pretendard(.bold, 12))
                        .foregroundColor(.grayscale85)
                        .padding(.top, 6)
                    Spacer()
                    SortSelectView(
                        sortType: .product,
                        sortBy: $myInfoViewModel.bookmarkSortBy,
                        sortClicked: $sortClicked
                    )
                }
                .padding(.horizontal,20)
                .zIndex(1)
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
                    .offset(y: 50)
                    .padding(.bottom, 50)
                }
            }
        }
        .onChange(of: sortClicked) { _ in
            myInfoViewModel.requestUserBookmarkList()
        }
    }
}
