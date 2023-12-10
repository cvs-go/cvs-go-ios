//
//  PopularProducts.swift
//  PyeonHae
//
//  Created by 정건호 on 2023/01/23.
//

import SwiftUI

struct PopularProducts: View {
//    @Binding var popularProducts: [Product]
    @ObservedObject var homeViewModel: HomeViewModel
    @State private var showToolTip = false
    
    var body: some View {
        VStack {
            Spacer().frame(height: 16)
            HStack {
                Spacer().frame(width: 20)
                Text("인기 상품")
                    .font(.pretendard(.bold, 18))
                    .foregroundColor(.grayscale100)
                ZStack(alignment: .leading) {
                    toolTip
                        .fixedSize(horizontal: false, vertical: true)
                        .offset(y: -32)
                        .opacity(showToolTip ? 1 : 0)
                    Image(name: .infoCircle)
                        .onTapGesture {
                            showToolTip.toggle()
                        }
                }
                .frame(height: 16)
                Spacer()
                Image(name: .arrowRight)
                Spacer().frame(width: 16)
            }
            Spacer().frame(height: 16)
            ForEach($homeViewModel.popularProducts, id: \.self) { popularProduct in
                PopularProductCell(popularProduct: popularProduct)
                    .padding(.bottom, 16)
            }
            Spacer().frame(height: 8)
        }
        .background(Color.white)
    }
    
    var toolTip: some View {
        Text("리뷰 개수, 좋아요 개수, 상품 평점을\n종합적으로 반영하여 인기상품을 선별합니다.")
            .font(.pretendard(.regular, 12))
            .foregroundColor(.white)
            .padding(EdgeInsets(top: 4, leading: 12, bottom: 4, trailing: 12))
            .background(Color.grayscale85.opacity(0.8))
            .cornerRadius(10)
    }
}
