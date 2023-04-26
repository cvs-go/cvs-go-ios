//
//  SearchResultItemView.swift
//  PyeonHae
//
//  Created by 이주화 on 2023/02/21.
//

import SwiftUI
import Kingfisher

struct SearchResultItemView: View {
    @State var isBookMark: Bool = false
    @State var isHeartMark: Bool = false
    let product: Product
    @Binding var selectedProductID: Int
    
    var body: some View {
        VStack {
            HStack {
                ZStack {
                    if let url = product.productImageUrl, let imageUrl = URL(string: url) {
                        KFImage(imageUrl)
                            .resizable()
                            .frame(width: 120, height: 120)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.grayscale30, lineWidth: 1)
                            )
                            .frame(width: 120, height: 120)
                    } else {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.grayscale30, lineWidth: 1)
                            .frame(width: 120, height: 120)
                    }
                }
                .frame(width: 120, height: 120)
                VStack(alignment: .leading, spacing: 0) {
                    Text(product.manufacturerName)
                        .font(.pretendard(.regular, 12))
                        .foregroundColor(.grayscale70)
                    HStack {
                        Text(product.productName)
                            .font(.pretendard(.semiBold, 16))
                            .foregroundColor(.grayscale100)
                        Spacer()
                        Button(action: {
                            isHeartMark.toggle()
                        }){
                            isHeartMark ? Image(name: .heartMarkFill) : Image(name: .heartMark)
                        }
                        Button(action: {
                            isBookMark.toggle()
                        }){
                            isBookMark ? Image(name: .bookMarkFill) : Image(name: .bookMark)
                        }
                    }
                    .padding(.bottom, 2)
                    Text("\(product.productPrice)원")
                        .font(.pretendard(.medium, 16))
                        .foregroundColor(.grayscale85)
                        .padding(.bottom, 8)
                    HStack {
                        Image(name: .redStar)
                        Text(product.reviewRating)
                            .font(.pretendard(.semiBold, 14))
                            .foregroundColor(.grayscale100)
                        Text("|")
                            .font(.pretendard(.semiBold, 14))
                            .foregroundColor(.grayscale30)
                        Text("\(product.reviewCount)개의 리뷰")
                            .font(.pretendard(.regular, 14))
                            .foregroundColor(.grayscale30)
                    }
                    .padding(.bottom, 8)
                    HStack(spacing: 4) {
                        Image(name: .logoCU)
                        Image(name: .logoGS)
                        Image(name: .logoMini)
                        Image(name: .logoEmart)
                        Image(name: .logoSeven)
                    }
                }
                .padding(.leading, 15)
            }
        }
        .padding(.horizontal,20)
        .onTapGesture {
            selectedProductID = product.productId
        }
    }
}
