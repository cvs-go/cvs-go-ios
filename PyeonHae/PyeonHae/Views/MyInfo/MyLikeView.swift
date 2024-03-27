//
//  MyLikeView.swift
//  PyeonHae
//
//  Created by 정건호 on 2023/07/27.
//

import SwiftUI

struct MyLikeView: View {
    @ObservedObject var myInfoViewModel: MyInfoViewModel
    @Binding var selectedProduct: Product?
    @Binding var showProductDetail: Bool
    @State private var sortClicked = false
    
    var body: some View {
        VStack(spacing: 0) {
            SortView(
                type: .myInfoLike,
                elementCount: myInfoViewModel.myLikeData?.totalElements ?? 0,
                sortBy: $myInfoViewModel.likeSortBy,
                sortClicked: $sortClicked,
                content: {
                    if let myLikeData = myInfoViewModel.myLikeData {
                        DefaultList {
                            ForEach(myLikeData.content.enumeratedArray(), id: \.element) { index, product in
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
                                            myInfoViewModel.myLikeData?.content.removeAll(where: { $0.productId == product.productId })
                                            myInfoViewModel.myLikeData?.totalElements -= 1
                                        },
                                        bookmarkAction: {
                                            myInfoViewModel.requestProductBookmark(productID: product.productId)
                                        },
                                        unBookmarkAction: {
                                            myInfoViewModel.requestProductUnBookmark(productID: product.productId)
                                        }
                                    )
                                    .onAppear {
                                        if myLikeData.content.count - 3 == index,
                                           !myInfoViewModel.likeLast {
                                            myInfoViewModel.likePage += 1
                                            myInfoViewModel.requestMoreMyLikeList()
                                        }
                                    }
                                }
                                .padding(.vertical, 10)
                            }
                        }
                    }
                },
                searchAction: {
                    myInfoViewModel.requestMyLikeList()
                }
            )
        }
    }
}
