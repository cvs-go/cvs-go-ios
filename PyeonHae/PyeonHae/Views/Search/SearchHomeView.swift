//
//  SearchHomeView.swift
//  PyeonHae
//
//  Created by 정건호 on 2023/04/19.
//

import SwiftUI

struct SearchHomeView: View {
    @State private var text = String()
    private let imageSize = (UIWindow().screen.bounds.width - 55) / 4
    @State private var startSearch = false
    
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
                destination: SearchStartView(text: $text).navigationBarHidden(true),
                isActive: $startSearch)
            {
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
                Image(name: .instantFoodImage)
                    .resizable()
                    .frame(width: imageSize, height: imageSize)
                Image(name: .snackImage)
                    .resizable()
                    .frame(width: imageSize, height: imageSize)
                Image(name: .icecreamImage)
                    .resizable()
                    .frame(width: imageSize, height: imageSize)
            }
            
            Spacer().frame(height: 6)
            
            HStack(spacing: 5) {
                Image(name: .freshFoodImage)
                    .resizable()
                    .frame(width: imageSize, height: imageSize)
                Image(name: .dairyProductImage)
                    .resizable()
                    .frame(width: imageSize, height: imageSize)
                Image(name: .beverageImage)
                    .resizable()
                    .frame(width: imageSize, height: imageSize)
                Image(name: .etcImage)
                    .resizable()
                    .frame(width: imageSize, height: imageSize)
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
