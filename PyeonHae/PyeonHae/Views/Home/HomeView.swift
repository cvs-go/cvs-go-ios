//
//  HomeView.swift
//  PyeonHae
//
//  Created by 정건호 on 2023/01/28.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var homeViewModel = HomeViewModel()
    
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
                    EventProducts()
                }
                Spacer().frame(height: 14)
                PopularProducts()
                Spacer().frame(height: 14)
                PopularReview()
            }
            .background(Color.grayscale20)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
