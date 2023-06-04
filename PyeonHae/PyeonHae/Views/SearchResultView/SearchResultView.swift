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
    @State private var showWriteView = false
    @State private var searchAgain = false
    @State private var selectedProductID = -1
    @State private var filterClicked = false
    @State private var minPrice: CGFloat = 0
    @State private var maxPrice: CGFloat = 1
    
    @State private var priceChangeDebounceTimer: AnyCancellable?
    
    var body: some View {
        VStack {
            SearchBar(
                text: $text,
                searchAgain: $searchAgain,
                searchBarType: .result
            )
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
            HStack {
                Spacer().frame(width: 20)
                Text("'\(searchViewModel.keyword)' 검색 결과 \(searchViewModel.searchResults?.data.totalElements ?? 0)개")
                    .font(.pretendard(.regular, 12))
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
                Spacer().frame(width: 20)
            }
            .padding(.bottom, 10)
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
                                SearchResultItemView(product: product, selectedProductID: $selectedProductID)
                            }
                            .padding(.vertical, 10)
                        }
                    }
                }
            }
            NavigationLink(destination: DetailItemView(searchViewModel: searchViewModel).navigationBarHidden(true), isActive: $searchViewModel.showProductDetail) {
                EmptyView()
            }
        }
        .onAppear {
            UIScrollView.appearance().keyboardDismissMode = .onDrag
            selectedProductID = -1
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
        .onChange(of: selectedProductID) { id in
            if selectedProductID != -1 {
                searchViewModel.requestProductDetail(productID: id) {
                    searchViewModel.showProductDetail = true
                }
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
