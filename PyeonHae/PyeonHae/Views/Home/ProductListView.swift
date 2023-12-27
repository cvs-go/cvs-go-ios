//
//  ProductListView.swift
//  PyeonHae
//
//  Created by 정건호 on 12/25/23.
//

import SwiftUI

struct ProductListView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    let type: ProductListType
    @ObservedObject var homeViewModel: HomeViewModel
    @ObservedObject var searchViewModel: SearchViewModel
    @State private var selectedProduct: Product? = nil
    @State private var showDetailView = false
    
    var body: some View {
        VStack {
            navigationBar
            HStack(alignment: .top) {
                Spacer().frame(width: 20)
                topView(type)
            }
            ZStack {
                VStack {
                    GeometryReader { geometry in
                        ScrollView {
                            ForEach(
                                type == .event ? homeViewModel.eventProducts : homeViewModel.popularProducts,
                                id: \.self) { product in
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
                                }
                                .padding(.vertical, 10)
                            }
                        }
                    }
                }
            }
            .navigationBarBackButtonHidden()
            
            NavigationLink(
                destination: DetailItemView(
                    searchViewModel: searchViewModel,
                    selectedProduct: $selectedProduct
                ),
                isActive: $showDetailView
            ) {
                EmptyView()
            }
        }
        .onChange(of: selectedProduct) { _ in
            if let selectedProduct = selectedProduct {
                self.searchViewModel.requestProductDetail(productID: selectedProduct.productId)
                self.searchViewModel.requestReview(productID: selectedProduct.productId)
                self.showDetailView = true
            }
        }
    }
    
    @ViewBuilder
    private var navigationBar: some View {
        VStack {
            HStack {
                Spacer().frame(width: 14)
                Image(name: .arrowLeft)
                    .onTapGesture {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                Spacer().frame(width: 6)
                Text(type == .event ? "행사상품" : "인기상품")
                    .font(.pretendard(.bold, 20))
                    .foregroundColor(.grayscale100)
                Spacer()
            }
        }
        .frame(height: 44)
    }
    
    @ViewBuilder
    private func topView(_ type: ProductListType) -> some View {
        if type == .event {
            Text("행사상품 총 \(homeViewModel.eventProductCount)개")
                .font(.pretendard(.regular, 12))
                .foregroundColor(.grayscale85)
                .padding(.top, 12)
            Spacer()
            //                SortSelectView(selectedOptionIndex: $selectedSortOptionIndex)
            //                    .padding(.top, 7)
            Spacer().frame(width: 20)
        } else {
            Text("00.00.00기준, 사람들에게\n인기있는 상품을 보여드릴게요.")
                .font(.pretendard(.regular, 14))
                .foregroundColor(.grayscale85)
            Spacer()
        }
    }
}

enum ProductListType {
    case event
    case popular
}
