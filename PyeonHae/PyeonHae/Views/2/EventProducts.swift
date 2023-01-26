//
//  EventProducts.swift
//  PyeonHae
//
//  Created by 정건호 on 2023/01/23.
//

import SwiftUI

struct EventProducts: View {
    var body: some View {
        VStack {
            HStack {
                Spacer().frame(width: 20)
                Text("행사 상품")
                    .font(.pretendard(.bold, 18))
                    .foregroundColor(.grayscale100)
                Spacer()
                Image(name: .arrowRight)
                Spacer().frame(width: 16)
            }
            Spacer().frame(height: 16)
            ScrollView(.horizontal) {
                HStack {
                    ForEach(0..<10){ cell in
                        EventProductCell()
                    }
                }
                .padding(.horizontal, 20)
            }
        }
    }
}

struct EventProducts_Previews: PreviewProvider {
    static var previews: some View {
        EventProducts()
    }
}
