//
//  SearchResultView.swift
//  PyeonHae
//
//  Created by 이주화 on 2023/02/21.
//

import SwiftUI
import Combine

struct SearchResultView: View {
    @ObservedObject var searchViewModel: SearchViewModel
    @Binding var text: String
    @State private var selectedElements: [String] = []
    @State private var showFilter = false
    @State private var searchAgain = false
    @State private var selectedProduct: Product? = nil
    @State private var filterClicked = false
    @State private var minPrice: CGFloat = 0
    @State private var maxPrice: CGFloat = 1
    
    @State private var showDetailView = false
    
    @State private var priceChangeDebounceTimer: AnyCancellable?
    
    var body: some View {
        VStack(alignment: .leading) {
            SearchBar(
                text: $text,
                searchAgain: $searchAgain,
                searchBarType: .result
            )
            ZStack {
                VStack {
                    Spacer().frame(height: showFilter ? 473 : 83)
                    GeometryReader { geometry in
                        ScrollView {
                            if searchViewModel.resultListIsLoading {
                                VStack {
                                    LoadingView()
                                }
                                .frame(width: geometry.size.width)
                                .frame(minHeight: geometry.size.height)
                            } else if searchViewModel.searchResults?.data.content.count == 0 {
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
                                .frame(width: geometry.size.width, height: geometry.size.height)
                            } else {
                                ForEach(searchViewModel.searchResults?.data.content.enumeratedArray() ?? [], id: \.element) { index, product in
                                    LazyVStack {
                                        SearchResultItemView(
                                            selectedProduct: $selectedProduct,
                                            isHeartMark: product.isLiked,
                                            isBookMark: product.isBookmarked,
                                            product: product,
                                            productViewType: .search,
                                            likeAction: {
                                                searchViewModel.requestProductLike(productID: product.productId)
                                                selectedProduct?.isLiked = true
                                            },
                                            unlikeAction: {
                                                searchViewModel.requestProductUnLike(productID: product.productId)
                                                selectedProduct?.isLiked = false
                                            },
                                            bookmarkAction: {
                                                searchViewModel.requestProductBookmark(productID: product.productId)
                                                selectedProduct?.isBookmarked = true
                                            },
                                            unBookmarkAction: {
                                                searchViewModel.requestProductUnBookmark(productID: product.productId)
                                                selectedProduct?.isBookmarked = true
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
                        .simultaneousGesture(DragGesture().onChanged { _ in
                            withAnimation(.easeInOut(duration: 0.25)) {
                                self.showFilter = false
                            }
                        })
                    }
                }
                VStack(spacing: 0) {
                    Spacer().frame(height: 10)
                    if let filtersData = UserShared.filterData {
                        SearchFilterView(
                            filterDatas: filtersData,
                            showFilter: $showFilter,
                            convenienceStoreIds: $searchViewModel.convenienceStoreIds,
                            categoryIds: $searchViewModel.categoryIds,
                            eventTypes: $searchViewModel.eventTypes,
                            filterClicked: $filterClicked,
                            minPrice: $minPrice,
                            maxPrice: $maxPrice
                        )
                    }
                    HStack(alignment: .top) {
                        Spacer().frame(width: 20)
                        Text("'\(searchViewModel.keyword)' 검색 결과 \(searchViewModel.searchResults?.data.totalElements ?? 0)개")
                            .font(.pretendard(.regular, 12))
                            .foregroundColor(.grayscale85)
                            .padding(.top, 12)
                        Spacer()
                        SortSelectView(
                            sortType: .product,
                            sortBy: $searchViewModel.sortBy,
                            searchAgain: $searchAgain
                        )
                        .padding(.top, 7)
                        Spacer().frame(width: 20)
                    }
                    Spacer()
                }
            }
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
        .onAppear {
            UIScrollView.appearance().keyboardDismissMode = .onDrag
        }
        .onChange(of: searchAgain) { _ in
            searchViewModel.keyword = text
            searchViewModel.searchProducts()
        }
        .onChange(of: filterClicked) { _ in
            searchViewModel.searchProducts()
        }
        .onChange(of: selectedProduct) { product in
            if let product = product {
                showDetailView = true
                searchViewModel.requestProductDetail(productID: product.productId)
                searchViewModel.requestReview(productID: product.productId)
                searchViewModel.requestProductTag(productId: product.productId)
            }
        }
        .onChange(of: minPrice) { minPrice in
            searchViewModel.lowestPrice = Int(minPrice * CGFloat(UserShared.filterData?.highestPrice ?? 0))
            priceChangeDebounceTimer?.cancel()
            priceChangeDebounceTimer = Future { promise in
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    promise(.success(()))
                }
            }.sink { _ in
                searchViewModel.searchProducts()
            }
        }
        .onChange(of: maxPrice) { maxPrice in
            searchViewModel.highestPrice = Int(maxPrice * CGFloat(UserShared.filterData?.highestPrice ?? 0))
            priceChangeDebounceTimer?.cancel()
            priceChangeDebounceTimer = Future { promise in
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    promise(.success(()))
                }
            }.sink { _ in
                searchViewModel.searchProducts()
            }
        }
    }
}
