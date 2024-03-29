//
//  ProductListView.swift
//  PyeonHae
//
//  Created by 정건호 on 12/25/23.
//

import SwiftUI

struct ProductListView: View {
    let type: ProductListType
    @ObservedObject var homeViewModel: HomeViewModel
    @ObservedObject var searchViewModel: SearchViewModel
    @State private var selectedProduct: Product? = nil
    @State private var showDetailView = false
    @Binding var searchAgain: Bool
    
    init(type: ProductListType,
         homeViewModel: HomeViewModel,
         searchViewModel: SearchViewModel,
         searchAgain: Binding<Bool> = .constant(false)
    ) {
        self.type = type
        self.homeViewModel = homeViewModel
        self.searchViewModel = searchViewModel
        self._searchAgain = searchAgain
    }
    
    var body: some View {
        VStack {
            NavigationBar(title: type == .event ? "행사상품" : "인기상품")
            ZStack(alignment: .topLeading) {
                topView(type)
                if homeViewModel.searchAgain {
                    GeometryReader { geometry in
                        LoadingView()
                            .frame(width: geometry.size.width, height: geometry.size.height)
                    }
                } else {
                    VStack {
                        DefaultList {
                            ForEach(
                                type == .event ? homeViewModel.eventProducts.enumeratedArray() : homeViewModel.popularProducts.enumeratedArray(),
                                id: \.element) { index, product in
                                    VStack {
                                        SearchResultItemView(
                                            selectedProduct: $selectedProduct,
                                            isHeartMark: product.isLiked,
                                            isBookMark: product.isBookmarked,
                                            product: product,
                                            productViewType: .search,
                                            likeAction: {
                                                homeViewModel.requestProductLike(productID: product.productId)
                                            },
                                            unlikeAction: {
                                                homeViewModel.requestProductUnlike(productID: product.productId)
                                            },
                                            bookmarkAction: {
                                                homeViewModel.requestProductBookmark(productID: product.productId)
                                            },
                                            unBookmarkAction: {
                                                homeViewModel.requestProductUnBookmark(productID: product.productId)
                                            }
                                        )
                                        .onAppear {
                                            if type == .event, homeViewModel.eventProducts.count - 3 == index,
                                               !homeViewModel.eventProductsLast {
                                                homeViewModel.eventProductsPage += 1
                                                homeViewModel.requestMoreEventProducts()
                                            }
                                        }
                                    }
                                    .padding(.vertical, 10)
                                }
                        }
                    }
                    .offset(y: 40)
                    .padding(.bottom, 40)
                }
            }
        }
        .onChange(of: selectedProduct) { _ in
            if let selectedProduct = selectedProduct {
                self.searchViewModel.requestProductDetail(productID: selectedProduct.productId)
                self.searchViewModel.requestReview(productID: selectedProduct.productId)
                searchViewModel.requestProductTag(productId: selectedProduct.productId)
                self.showDetailView = true
            }
        }
        .onChange(of: searchAgain) { _ in
            self.homeViewModel.searchAgain = true
            self.homeViewModel.requestEventProducts()
        }
        .navigationDestination(isPresented: $showDetailView) {
            DetailItemView(
                searchViewModel: searchViewModel,
                selectedProduct: $selectedProduct
            )
        }
    }
    
    @ViewBuilder
    private func topView(_ type: ProductListType) -> some View {
        if type == .event {
            HStack(alignment: .top) {
                Spacer().frame(width: 20)
                Text("행사상품 총 \(homeViewModel.eventProductCount)개")
                    .font(.pretendard(.regular, 12))
                    .foregroundColor(.grayscale85)
                    .padding(.top, 12)
                Spacer()
                SortSelectView(
                    sortType: .product,
                    sortBy: $homeViewModel.sortBy,
                    sortClicked: $searchAgain
                )
                .padding(.top, 7)
                Spacer().frame(width: 20)
            }.zIndex(1)
        } else {
            HStack(spacing: 0) {
                Spacer().frame(width: 20)
                Text("\(Date().currentDate())기준, 사람들에게\n인기있는 상품을 보여드릴게요.")
                    .font(.pretendard(.regular, 14))
                    .foregroundColor(.grayscale85)
                Spacer()
            }
        }
    }
}

enum ProductListType {
    case event
    case popular
}
