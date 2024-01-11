//
//  HomeView.swift
//  PyeonHae
//
//  Created by 정건호 on 2023/01/28.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var homeViewModel = HomeViewModel()
    @ObservedObject var searchViewModel = SearchViewModel()
    @State private var showEventProducts = false
    @State private var showPopularProducts = false
    @State private var showProductDetail = false
    @State private var selectedProduct: Product? = nil
    @State private var searchAgain = false
    
    var body: some View {
        if homeViewModel.isLoading {
            LoadingView()
        } else {
            VStack {
                HStack {
                    Spacer().frame(width: 20)
                    Text("편해")
                        .font(.pretendard(.bold, 20))
                        .foregroundColor(.grayscale100)
                    Spacer()
                    Image(name: .notification)
                    Spacer().frame(width: 18)
                }
                .frame(height: 44)
                ScrollView {
                    VStack(spacing: 0) {
                        MainBanner(promotions: $homeViewModel.promotions)
                        EventProducts(
                            searchViewModel: searchViewModel,
                            eventProducts: $homeViewModel.eventProducts,
                            selectedProduct: $selectedProduct,
                            showEventProducts: $showEventProducts,
                            showProductDetail: $showProductDetail
                        )
                        Spacer().frame(height: 14)
                        PopularProducts(
                            homeViewModel: homeViewModel,
                            searchViewModel: searchViewModel,
                            showPopularProducts: $showPopularProducts,
                            selectedProduct: $selectedProduct,
                            showProductDetail: $showProductDetail
                        )
                        Spacer().frame(height: 14)
                        PopularReview(
                            homeViewModel: homeViewModel,
                            searchViewModel: searchViewModel,
                            selectedProduct: $selectedProduct,
                            showProductDetail: $showProductDetail
                        )
                        Spacer().frame(height: 22)
                    }
                }
                .background(Color.grayscale20)
                .navigationDestination(isPresented: $showEventProducts) {
                    ProductListView(
                        type: .event,
                        homeViewModel: homeViewModel,
                        searchViewModel: searchViewModel,
                        searchAgain: $searchAgain
                    )
                }
                .navigationDestination(isPresented: $showPopularProducts) {
                    ProductListView(
                        type: .popular,
                        homeViewModel: homeViewModel,
                        searchViewModel: searchViewModel
                    )
                }
                .navigationDestination(isPresented: $showProductDetail) {
                    DetailItemView(
                        searchViewModel: searchViewModel,
                        selectedProduct: $selectedProduct
                    )
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
