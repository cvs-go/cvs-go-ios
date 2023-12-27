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
    @State private var showEventDetail = false
    @State private var showPopularProducts = false
    @State private var selectedProduct: Product? = nil
    
    var body: some View {
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
                        showEventDetail: $showEventDetail
                    )
                    Spacer().frame(height: 14)
                    PopularProducts(
                        homeViewModel: homeViewModel,
                        showPopularProducts: $showPopularProducts
                    )
                    Spacer().frame(height: 14)
                    PopularReview(homeViewModel: homeViewModel)
                    Spacer().frame(height: 22)
                }
            }
            .background(Color.grayscale20)
            
            NavigationLink(
                destination: ProductListView(
                    type: .event,
                    homeViewModel: homeViewModel,
                    searchViewModel: searchViewModel
                ),
                isActive: $showEventProducts
            ) {
                EmptyView()
            }
            
            NavigationLink(
                destination: ProductListView(
                    type: .popular,
                    homeViewModel: homeViewModel,
                    searchViewModel: searchViewModel
                ),
                isActive: $showPopularProducts
            ) {
                EmptyView()
            }
            
            NavigationLink(
                destination: DetailItemView(
                    searchViewModel: searchViewModel,
                    selectedProduct: $selectedProduct
                ),
                isActive: $showEventDetail
            ) {
                EmptyView()
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
