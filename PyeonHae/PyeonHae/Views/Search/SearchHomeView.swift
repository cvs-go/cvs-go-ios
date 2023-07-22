//
//  SearchHomeView.swift
//  PyeonHae
//
//  Created by 정건호 on 2023/04/19.
//

import SwiftUI

struct SearchHomeView: View {
    @ObservedObject var searchViewModel = SearchViewModel()
    
    @State private var text = String()
    private let imageSize = (UIWindow().screen.bounds.width - 55) / 4
    @State private var startSearch = false
    @State private var showSearchResult = false
    
    var body: some View {
        VStack {
            SearchBar(text: $text, searchBarType: .home)
                .onTapGesture {
                    startSearch = true
                }
            Spacer().frame(height: 20)
            ProductCategories
            Spacer()
            NavigationLink(
                destination: SearchStartView(
                    searchViewModel: searchViewModel,
                    text: $text
                ).navigationBarHidden(true),
                isActive: $startSearch)
            {
                EmptyView()
            }
            NavigationLink(
                destination: SearchResultView(
                    searchViewModel: searchViewModel,
                    text: $text
                ).navigationBarHidden(true),
                isActive: $showSearchResult
            ) {
                EmptyView()
            }
        }
    }
   
    var ProductCategories: some View {
        VStack {
            HStack {
                Text("제품")
                    .font(.pretendard(.bold, 14))
                    .foregroundColor(.grayscale100)
                Spacer()
            }
            
            HStack(spacing: 5) {
                Image(name: .foodImage)
                    .resizable()
                    .frame(width: imageSize, height: imageSize)
                    .onTapGesture {
                        searchViewModel.categoryIds = [1]
                        searchViewModel.searchProducts()
                        searchViewModel.isLoading = true
                        showSearchResult = true
                    }
                Image(name: .instantFoodImage)
                    .resizable()
                    .frame(width: imageSize, height: imageSize)
                    .onTapGesture {
                        searchViewModel.categoryIds = [2]
                        searchViewModel.searchProducts()
                        searchViewModel.isLoading = true
                        showSearchResult = true
                    }
                Image(name: .snackImage)
                    .resizable()
                    .frame(width: imageSize, height: imageSize)
                    .onTapGesture {
                        searchViewModel.categoryIds = [3]
                        searchViewModel.searchProducts()
                        searchViewModel.isLoading = true
                        showSearchResult = true
                    }
                Image(name: .icecreamImage)
                    .resizable()
                    .frame(width: imageSize, height: imageSize)
                    .onTapGesture {
                        searchViewModel.categoryIds = [4]
                        searchViewModel.searchProducts()
                        searchViewModel.isLoading = true
                        showSearchResult = true
                    }
            }
            
            Spacer().frame(height: 6)
            
            HStack(spacing: 5) {
                Image(name: .freshFoodImage)
                    .resizable()
                    .frame(width: imageSize, height: imageSize)
                    .onTapGesture {
                        searchViewModel.categoryIds = [5]
                        searchViewModel.searchProducts()
                        searchViewModel.isLoading = true
                        showSearchResult = true
                    }
                Image(name: .dairyProductImage)
                    .resizable()
                    .frame(width: imageSize, height: imageSize)
                    .onTapGesture {
                        searchViewModel.categoryIds = [6]
                        searchViewModel.searchProducts()
                        searchViewModel.isLoading = true
                        showSearchResult = true
                    }
                Image(name: .beverageImage)
                    .resizable()
                    .frame(width: imageSize, height: imageSize)
                    .onTapGesture {
                        searchViewModel.categoryIds = [7]
                        searchViewModel.searchProducts()
                        searchViewModel.isLoading = true
                        showSearchResult = true
                    }
                Image(name: .etcImage)
                    .resizable()
                    .frame(width: imageSize, height: imageSize)
                    .onTapGesture {
                        searchViewModel.categoryIds = [8]
                        searchViewModel.searchProducts()
                        searchViewModel.isLoading = true
                        showSearchResult = true
                    }
            }
        }
        .padding(.horizontal, 20)
    }
}

struct SearchHomeView_Previews: PreviewProvider {
    static var previews: some View {
        SearchHomeView()
    }
}
