//
//  SearchResultView.swift
//  PyeonHae
//
//  Created by 이주화 on 2023/02/21.
//

import SwiftUI

struct SearchResultView: View {
    @ObservedObject var searchViewModel: SearchViewModel
    @Binding var text: String
    @State private var selectedElements: [String] = []
    @State private var showFilter = false
    @State private var showWriteView = false
    @State private var searchAgain = false
    
    var body: some View {
        VStack {
            SearchBar(
                text: $text,
                searchAgain: $searchAgain,
                searchBarType: .result
            )
            FilterView(
                filterDatas: searchViewModel.filtersData!,
                showFilter: $showFilter,
                selectedElements: $selectedElements
            )
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
                ForEach(searchViewModel.searchResults?.data.content ?? [], id: \.self) { product in
                    VStack {
                        SearchResultItemView(product: product)
                    }
                    .padding(.vertical, 10)
                }
            }
        }
        .onAppear {
            UIScrollView.appearance().keyboardDismissMode = .onDrag
            searchViewModel.keyword = text
            searchViewModel.searchProducts()
        }
        .onChange(of: searchAgain) { _ in
            searchViewModel.keyword = text
            searchViewModel.searchProducts()
        }
    }
    
    @ViewBuilder
    private func allReviewTab() -> some View {
        ScrollView {
            VStack(spacing: 0) {
                Spacer().frame(height: 10)
                FilterView(
                    filterDatas: searchViewModel.filtersData!,
                    showFilter: $showFilter,
                    selectedElements: $selectedElements
                )
                HStack {
                    Spacer().frame(width: 20)
                    Text("새로운 리뷰 14개")
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
                .frame(height: 40)
            }
            ForEach(0..<10) { _ in
                VStack {
                    ReviewUserInfo(reviewType: .normal)
                    ReviewCell()
                }
                .padding(.horizontal, 19)
                Color.grayscale30.opacity(0.5).frame(height: 1)
                    .padding(.bottom, 16)
            }
        }
    }
}
