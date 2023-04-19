//
//  SearchHomeView.swift
//  PyeonHae
//
//  Created by 정건호 on 2023/04/19.
//

import SwiftUI

struct SearchHomeView: View {
    @State var text = String()
    private let imageSize = (UIWindow().screen.bounds.width - 55) / 4
    var body: some View {
        VStack {
            SearchBar(text: $text)
            Spacer().frame(height: 20)
            ProductCategories
            Spacer()
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
