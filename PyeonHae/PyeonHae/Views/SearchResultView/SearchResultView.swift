//
//  SearchResultView.swift
//  PyeonHae
//
//  Created by 이주화 on 2023/02/21.
//

import SwiftUI
import EasySkeleton

struct SearchResultView: View {
    @ObservedObject var searchViewModel: SearchViewModel
    @Binding var text: String
    @State private var selectedElements: [String] = []
    @State private var showFilter = false
    @State private var showWriteView = false
    @State private var searchAgain = false
    @State private var selectedProductID = -1
    
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
                    selectedElements: $selectedElements
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
            ScrollView {
                if searchViewModel.isLoading {
                    ForEach(0...5, id: \.self) { _ in
                        SearchResultItemSkeletonView(isLoading: $searchViewModel.isLoading)
                            .padding(.vertical, 10)
                    }
                    .setSkeleton(
                        $searchViewModel.isLoading,
                        animationType: .solid(.grayscale25),
                        animation: Animation.easeIn(duration: 2),
                        transition: AnyTransition.opacity
                    )
                } else {
                    ForEach(searchViewModel.searchResults?.data.content ?? [], id: \.self) { product in
                        VStack {
                            SearchResultItemView(product: product, selectedProductID: $selectedProductID)
                        }
                        .padding(.vertical, 10)
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
            searchViewModel.isLoading = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                searchViewModel.isLoading = false
            }
        }
        .onChange(of: searchAgain) { _ in
            searchViewModel.keyword = text
            searchViewModel.searchProducts()
            searchViewModel.isLoading = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                searchViewModel.isLoading = false
            }
        }
        .onChange(of: selectedProductID) { id in
            if selectedProductID != -1 {
                searchViewModel.requestProductDetail(productID: id) {
                    searchViewModel.showProductDetail = true
                }
            }
        }
    }
}
