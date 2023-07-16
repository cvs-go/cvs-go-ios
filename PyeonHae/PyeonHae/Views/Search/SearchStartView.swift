//
//  SearchStartView.swift
//  PyeonHae
//
//  Created by 정건호 on 2023/04/19.
//

import SwiftUI
import Kingfisher

struct SearchStartView: View {
    @ObservedObject var searchViewModel = SearchViewModel()
    
    @Binding var text: String
    @State private var showResultView = false
    @State private var searchedProducts: [SearchedProduct] = []
    @State private var searchedKeywords: [SearchedKeyword] = []
    
    var body: some View {
        VStack {
            SearchBar(
                text: $text,
                showResultView: $showResultView,
                searchBarType: .start
            )
            Spacer().frame(height: 14)
            Group {
                // 최근 찾은 상품
                if !searchedProducts.isEmpty {
                    VStack {
                        HStack {
                            Text("최근 찾은 상품")
                                .font(.pretendard(.bold, 14))
                                .foregroundColor(.grayscale100)
                            Spacer()
                            Text("전체삭제")
                                .font(.pretendard(.regular, 12))
                                .foregroundColor(.grayscale70)
                                .underline(true, color: .grayscale70)
                        }
                        .padding(.horizontal, 20)
                        Spacer().frame(height: 10)
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                Spacer().frame(width: 24)
                                ForEach(searchedProducts, id: \.self) { product in
                                    searchedProductView(product)
                                }
                            }
                        }
                    }
                }
                // 이전 검색어
                if !searchedKeywords.isEmpty {
                    VStack {
                        HStack {
                            Text("이전 검색어")
                                .font(.pretendard(.bold, 14))
                                .foregroundColor(.grayscale100)
                            Spacer()
                            Text("전체삭제")
                                .font(.pretendard(.regular, 12))
                                .foregroundColor(.grayscale70)
                                .underline(true, color: .grayscale70)
                        }
                        .padding(.horizontal, 20)
                        Spacer().frame(height: 10)
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                Spacer().frame(width: 24)
                                ForEach(searchedKeywords, id: \.self) { keyword in
                                    searchedKeywordView(keyword)
                                }
                            }
                        }
                    }
                }
                
                // 인기 검색어
                VStack {
                    HStack {
                        Text("인기 검색어")
                            .font(.pretendard(.bold, 14))
                            .foregroundColor(.grayscale100)
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                }
                Spacer()
            }
            .onChange(of: showResultView) { _ in
                searchViewModel.keyword = text
                searchViewModel.searchProducts()
                // 이전 검색어 저장
                if !UserShared.searchedKeyword.map({ $0.keyword }).contains(text) {
                    UserShared.searchedKeyword.append(.init(
                        timestamp: Date().currentTime(),
                        keyword: text
                    ))
                }
            }
            
            NavigationLink(
                destination: SearchResultView(
                    searchViewModel: searchViewModel,
                    text: $text
                ).navigationBarHidden(true),
                isActive: $showResultView
            ) {
                EmptyView()
            }
        }
        .onAppear {
            self.searchedProducts = UserShared.searchedProducts.sorted(by: { $0.timestamp > $1.timestamp })
            self.searchedKeywords = UserShared.searchedKeyword.sorted(by: { $0.timestamp > $1.timestamp })
        }
    }
    
    private func deleteSearchedProduct(_ productId: Int) {
        UserShared.searchedProducts.removeAll(where: { $0.productId == productId })
        searchedProducts.removeAll(where: { $0.productId == productId })
    }
    
    private func deleteSearchedKeyword(_ keyword: String) {
        UserShared.searchedKeyword.removeAll(where: { $0.keyword == keyword })
        searchedKeywords.removeAll(where: { $0.keyword == keyword })
    }
    
    @ViewBuilder
    private func searchedProductView(_ product: SearchedProduct) -> some View {
        if let url = URL(string: product.productImageUrl) {
            ZStack(alignment: .topTrailing) {
                Image(name: .roundedClose)
                    .padding(.top, 4)
                    .padding(.trailing, 4)
                    .zIndex(1)
                    .onTapGesture {
                        deleteSearchedProduct(product.productId)
                    }
                
                KFImage(url)
                    .resizable()
                    .frame(width: 72, height: 72)
                    .overlay(RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.grayscale20, lineWidth: 1)
                    )
            }
        }
    }
    
    @ViewBuilder
    private func searchedKeywordView(_ keyword: SearchedKeyword) -> some View {
        HStack(spacing: 3) {
            Text(keyword.keyword)
                .font(.pretendard(.medium, 14))
                .foregroundColor(.grayscale100)
            Image(name: .close)
                .resizable()
                .renderingMode(.template)
                .foregroundColor(.grayscale50)
                .frame(width: 9, height: 9)
                .onTapGesture {
                    deleteSearchedKeyword(keyword.keyword)
                }
        }
        .padding(.vertical, 6.5)
        .padding(.horizontal, 8)
        .background(Color.grayscale20)
        .cornerRadius(10)
    }
}
