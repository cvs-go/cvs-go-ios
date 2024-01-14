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
            SortView(
                type: .myInfoBookmark,
                elementCount: myInfoViewModel.myBookmarkData?.totalElements ?? 0,
                sortBy: $myInfoViewModel.bookmarkSortBy,
                sortClicked: $sortClicked,
                content: {
                    if let myBookmarkData = myInfoViewModel.myBookmarkData {
                        ScrollView {
                            ForEach(myBookmarkData.content.enumeratedArray(), id: \.element) { index, product in
                                LazyVStack {
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
                                    .onAppear {
                                        if myBookmarkData.content.count - 3 == index,
                                           !myInfoViewModel.bookmarkLast {
                                            myInfoViewModel.bookmarkPage += 1
                                            myInfoViewModel.requestMoreMyBookmarkList()
                                        }
                                    }
                                }
                                .padding(.vertical, 10)
                            }
                        }
                    }
                },
                searchAction: {
                    myInfoViewModel.requestMyBookmarkList()
                }
            )
        }
    }
}
