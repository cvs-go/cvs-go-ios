//
//  SearchProductView.swift
//  PyeonHae
//
//  Created by 정건호 on 2023/02/25.
//

import SwiftUI

struct SearchProductView: View {
    @ObservedObject var searchViewModel: SearchViewModel
    
    @State private var searchText = String()
    @Binding var showSearchProductView: Bool
    @Binding var selectedProduct: Product?
    
    @FocusState private var isFocused: Bool
    
    var body: some View {
        VStack {
            topBar
            Spacer().frame(height: 31)
            searchBar
                .padding(.horizontal, 20)
            GeometryReader { geometry in
                if let searchResults = searchViewModel.searchResults {
                    if searchResults.data.totalElements == 0 {
                        VStack(alignment: .center, spacing: 0) {
                            Image(name: .findProduct)
                            Spacer().frame(height: 12)
                            Text("찾으시는 상품이 없어요!")
                                .font(.pretendard(.semiBold, 16))
                                .foregroundColor(.grayscale85)
                            Spacer().frame(height: 2)
                            Text("다른 상품은 어떠신가요?")
                                .font(.pretendard(.light, 14))
                                .foregroundColor(.grayscale70)
                        }
                        .frame(width: geometry.size.width)
                        .frame(height: isFocused ? geometry.size.height / 2 : geometry.size.height)
                    }
                     DefaultList {
                        VStack {
                            ForEach(searchResults.data.content.enumeratedArray(), id: \.element) { index, product in
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
                                    .onAppear {
                                        if let data = searchViewModel.searchResults?.data,
                                           data.content.count - 3 == index, !data.last {
                                            searchViewModel.page += 1
                                            searchViewModel.searchMoreProducts()
                                        }
                                    }
                                }
                                .padding(.vertical, 10)
                            }
                        }
                    }
                    .scrollDismissesKeyboard(.immediately)
                } else {
                    VStack(alignment: .center, spacing: 0) {
                        Image(name: .findProduct)
                        Spacer().frame(height: 12)
                        Text("어떤 상품을 찾고 싶으신가요?")
                            .font(.pretendard(.semiBold, 16))
                            .foregroundColor(.grayscale85)
                        Spacer().frame(height: 2)
                        Text("원하는 상품을 입력해주세요.")
                            .font(.pretendard(.light, 14))
                            .foregroundColor(.grayscale70)
                    }
                    .frame(width: geometry.size.width)
                    .frame(height: isFocused ? geometry.size.height / 2 : geometry.size.height)
                }
            }
        }
        .onChange(of: selectedProduct) { product in
            if let product = product {
                selectedProduct = product
                showSearchProductView = false
            }
        }
        .onDisappear {
            searchViewModel.searchResults = nil
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
            .focused($isFocused)
            .submitLabel(.done)
            .onSubmit {
                searchViewModel.keyword = searchText
                searchViewModel.searchProducts()
            }
            Spacer()
            Image(name: .searchIcon)
                .resizable()
                .frame(width: 24, height: 24)
                .foregroundColor(.grayscale85)
                .padding(.vertical, 10)
                .padding(.trailing, 20)
                .onTapGesture {
                    isFocused = false
                    searchViewModel.keyword = searchText
                    searchViewModel.searchProducts()
                }
        }
    }
}
