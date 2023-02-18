//
//  PopularProductCell.swift
//  PyeonHae
//
//  Created by 정건호 on 2023/01/21.
//

import SwiftUI

struct PopularProductCell: View {
    var body: some View {
        HStack(spacing: 15) {
            ZStack {
                Image(name: .sampleImage)
                    .resizable()
            }
            .frame(width: 120, height: 120)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.borderColor)
                )
            VStack(alignment: .leading) {
                Text("해드림")
                    .font(.pretendard(.regular, 12))
                    .foregroundColor(.grayscale70)
                Text("매콤 투움바 퓨전 파스타")
                    .font(.pretendard(.semiBold, 16))
                    .foregroundColor(.grayscale100)
                Text("9,900원")
                    .font(.pretendard(.medium, 16))
                    .foregroundColor(.grayscale85)
                HStack {
                    Image(name: .redStar)
                    Text("4.5")
                        .font(.pretendard(.semiBold, 14))
                        .foregroundColor(.grayscale100)
                    Image(name: .rectengle)
                    Text("5,000개의 리뷰")
                        .font(.pretendard(.regular, 12))
                        .foregroundColor(.grayscale70)
                }
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 10)
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

struct PopularProductCell_Previews: PreviewProvider {
    static var previews: some View {
        PopularProductCell()
    }
}
