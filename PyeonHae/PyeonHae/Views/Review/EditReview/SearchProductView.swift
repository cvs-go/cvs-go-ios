//
//  SearchProductView.swift
//  PyeonHae
//
//  Created by 정건호 on 2023/02/25.
//

import SwiftUI

struct SearchProductView: View {
    @ObservedObject var searchViewModel = SearchViewModel()
    
    @State private var searchText = String()
    @Binding var showSearchProductView: Bool
    @Binding var selectedProduct: Product?
    
    var body: some View {
        VStack {
            topBar
            Spacer().frame(height: 31)
            searchBar
                .padding(.horizontal, 20)
            ScrollView {
                VStack {
                    ForEach(searchViewModel.searchResults?.data.content ?? [], id: \.self) { product in
                        VStack {
                            SearchResultItemView(
                                selectedProduct: $selectedProduct,
                                isHeartMark: product.isLiked,
                                isBookMark: product.isBookmarked,
                                product: product,
                                productViewType: .review,
                                likeAction: {
                                    searchViewModel.requestProductLike(productID: product.productId)
                                },
                                unlikeAction: {
                                    searchViewModel.requestProductUnLike(productID: product.productId)
                                },
                                bookmarkAction: {
                                    searchViewModel.requestProductBookmark(productID: product.productId)
                                },
                                unBookmarkAction: {
                                    searchViewModel.requestProductUnBookmark(productID: product.productId)
                                }
                            )
                        }
                        .padding(.vertical, 10)
                    }
                }
            }
        }
        .onChange(of: selectedProduct) { product in
            if let product = product {
                selectedProduct = product
                showSearchProductView = false
            }
        }
    }
    
    var topBar: some View {
        HStack {
            Spacer().frame(width: 20)
            Image(name: .close)
                .hidden()
            Spacer()
            Text("제품 검색")
                .font(.pretendard(.bold, 20))
                .foregroundColor(.grayscale100)
            Spacer()
            Image(name: .close)
                .onTapGesture {
                    showSearchProductView = false
                }
            Spacer().frame(width: 20)
        }
    }
    
    var searchBar: some View {
        ZStack(alignment: .trailing) {
            TextField(
                String(),
                text: $searchText,
                prompt: Text("찾고싶은 상품을 입력하세요.")
                    .font(.pretendard(.regular, 14))
                    .foregroundColor(.grayscale50)
            )
            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 50))
            .frame(height: 44)
            .font(.pretendard(.regular, 16))
            .background(Color.grayscale10)
            .cornerRadius(10)
            Spacer()
            Image(name: .searchIcon)
                .resizable()
                .frame(width: 24, height: 24)
                .foregroundColor(.grayscale85)
                .padding(.vertical, 10)
                .padding(.trailing, 20)
                .onTapGesture {
                    searchViewModel.keyword = searchText
                    searchViewModel.searchProducts()
                }
        }
    }
}
