//
//  PopularProductCell.swift
//  PyeonHae
//
//  Created by 정건호 on 2023/01/21.
//

import SwiftUI
import Kingfisher

struct PopularProductCell: View {
    @Binding var popularProduct: Product
    
    var body: some View {
        HStack(spacing: 15) {
            ZStack {
                if let imageUrl = popularProduct.productImageUrl, let url = URL(string: imageUrl) {
                    KFImage(url)
                        .resizable()
                }
            }
            .frame(width: 120, height: 120)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.borderColor)
            )
            VStack(alignment: .leading) {
                Text(popularProduct.manufacturerName)
                    .font(.pretendard(.regular, 12))
                    .foregroundColor(.grayscale70)
                Text(popularProduct.productName)
                    .font(.pretendard(.semiBold, 16))
                    .foregroundColor(.grayscale100)
                Text("\(popularProduct.productPrice)원")
                    .font(.pretendard(.medium, 16))
                    .foregroundColor(.grayscale85)
                HStack {
                    Image(name: .redStar)
                    Text(popularProduct.reviewRating)
                        .font(.pretendard(.semiBold, 14))
                        .foregroundColor(.grayscale100)
                    Image(name: .rectengle)
                    Text("\(popularProduct.reviewCount)개의 리뷰")
                        .font(.pretendard(.regular, 12))
                        .foregroundColor(.grayscale70)
                }
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 10)
                    // TODO: 상품 태그 api 호출
                    Text("이 제품을 주로 찾는 맵찔이에요.")
                        .lineLimit(1)
                        .font(.pretendard(.regular, 12))
                        .foregroundColor(.grayscale70)
                        .zIndex(1)
                        .padding(.horizontal, 12)
                }
                .foregroundColor(.grayscale20)
                .frame(height: 23)
            }
        }
        .padding(.horizontal, 20)
    }
}
