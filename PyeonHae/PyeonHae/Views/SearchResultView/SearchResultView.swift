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
    @State var selectedSortOptionIndex = 0
    
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
                            if searchViewModel.isLoading {
                                VStack {
                                    LoadingView()
                                }
                                .frame(width: geometry.size.width)
                                .frame(minHeight: geometry.size.height)
                            } else {
                                ForEach(searchViewModel.searchResults?.data.content ?? [], id: \.self) { product in
                                    VStack {
                                        SearchResultItemView(
                                            product: product,
                                            selectedProduct: $selectedProduct
                                        )
                                    }
                                    .padding(.vertical, 10)
                                }
                            }
                        }
                    }
                }
                VStack(spacing: 0) {
                    if let filtersData = searchViewModel.filtersData {
                        FilterView(
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
                        SortSelectView(selectedOptionIndex: $selectedSortOptionIndex)
                            .padding(.top, 7)
                        Spacer().frame(width: 20)
                    }
                    Spacer()
                }
            }
            NavigationLink(destination: DetailItemView(searchViewModel: searchViewModel).navigationBarHidden(true), isActive: $searchViewModel.showProductDetail) {
                EmptyView()
            }
        }
        .onAppear {
            UIScrollView.appearance().keyboardDismissMode = .onDrag
            selectedProduct = nil
        }
        .onChange(of: searchAgain) { _ in
            searchViewModel.keyword = text
            searchViewModel.searchProducts()
            searchViewModel.isLoading = true
        }
        .onChange(of: filterClicked) { _ in
            searchViewModel.searchProducts()
            searchViewModel.isLoading = true
        }
        .onChange(of: selectedProduct) { product in	
            if let product = product {
                searchViewModel.requestProductDetail(productID: product.productId)
                searchViewModel.requestReview(productID: product.productId)
            }
        }
        .onChange(of: minPrice) { minPrice in
            searchViewModel.lowestPrice = Int(minPrice * CGFloat(searchViewModel.filtersData?.highestPrice ?? 15000))
            priceChangeDebounceTimer?.cancel()
            priceChangeDebounceTimer = Future { promise in
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    promise(.success(()))
                }
            }.sink { _ in
                searchViewModel.searchProducts()
                searchViewModel.isLoading = true
            }
        }
        .onChange(of: maxPrice) { maxPrice in
            searchViewModel.highestPrice = Int(maxPrice * CGFloat(searchViewModel.filtersData?.highestPrice ?? 15000))
            priceChangeDebounceTimer?.cancel()
            priceChangeDebounceTimer = Future { promise in
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    promise(.success(()))
                }
            }.sink { _ in
                searchViewModel.searchProducts()
                searchViewModel.isLoading = true
            }
        }
    }
}
