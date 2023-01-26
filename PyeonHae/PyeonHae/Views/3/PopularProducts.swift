//
//  PopularProducts.swift
//  PyeonHae
//
//  Created by 정건호 on 2023/01/23.
//

import SwiftUI

struct PopularProducts: View {
    var body: some View {
        VStack {
            HStack {
                Spacer().frame(width: 20)
                Text("인기 상품")
                    .font(.pretendard(.bold, 18))
                    .foregroundColor(.grayscale100)
                Image(name: .infoCircle)
                Spacer()
                Image(name: .arrowRight)
                Spacer().frame(width: 16)
            }
            Spacer().frame(height: 16)
            ForEach(0..<3) { _ in
                PopularProductCell()
                    .padding(.bottom, 16)
            }
        }
    }
}

struct PopularProducts_Previews: PreviewProvider {
    static var previews: some View {
        PopularProducts()
    }
}
