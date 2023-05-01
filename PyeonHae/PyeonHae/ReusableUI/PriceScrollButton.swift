//
//  PriceScrollButton.swift
//  PyeonHae
//
//  Created by 이주화 on 2023/05/01.
//

import SwiftUI

struct PriceScrollButton: View {
    @State private var minPrice: CGFloat = 0
    @State private var maxPrice: CGFloat = 1
    @State private var minPriceDragOffset: CGSize = .zero
    @State private var maxPriceDragOffset: CGSize = .zero
    
    let trackWidth: CGFloat = 335
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("가격")
                .font(.pretendard(.bold, 12))
                .foregroundColor(Color.grayscale85)
            ZStack {
                HStack(spacing: 0) {
                    Rectangle()
                        .foregroundColor(Color.grayscale100)
                        .frame(width: trackWidth * minPrice, height: 8)
                    Rectangle()
                        .foregroundColor(Color.grayscale100)
                        .frame(width: trackWidth * (maxPrice - minPrice), height: 8)
                    Rectangle()
                        .foregroundColor(Color.grayscale30)
                        .frame(width: trackWidth * (1 - maxPrice), height: 8)
                }
                HStack {
                    Image(name: .PriceScrollButton)
                        .resizable()
                        .frame(width: 32, height: 32)
                        .offset(x: minPriceDragOffset.width)
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    let newMinPrice = max(0, minPrice + value.translation.width / trackWidth)
                                    if newMinPrice < maxPrice {
                                        minPrice = newMinPrice
                                        minPriceDragOffset.width = value.translation.width
                                    }
                                }
                                .onEnded { _ in
                                    minPriceDragOffset = .zero
                                }
                        )
                    Spacer().frame(width: trackWidth * (maxPrice - minPrice) - 32)
                    Image(name: .PriceScrollButton)
                        .resizable()
                        .frame(width: 32, height: 32)
                        .offset(x: maxPriceDragOffset.width)
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    let newMaxPrice = min(1, maxPrice + value.translation.width / trackWidth)
                                    if newMaxPrice > minPrice {
                                        maxPrice = newMaxPrice
                                        maxPriceDragOffset.width = value.translation.width
                                    }
                                }
                                .onEnded { _ in
                                    maxPriceDragOffset = .zero
                                }
                        )
                    Spacer()
                }
            }
            HStack(spacing: 87) {
                Text("최소")
                    .font(.pretendard(.regular, 12))
                    .foregroundColor(Color.grayscale70)
                Text("5천")
                    .font(.pretendard(.regular, 12))
                    .foregroundColor(Color.grayscale70)
                Text("1만")
                    .font(.pretendard(.regular, 12))
                    .foregroundColor(Color.grayscale70)
                Text("최대")
                    .font(.pretendard(.regular, 12))
                    .foregroundColor(Color.grayscale70)
            }
        }
    }
}

struct PriceScrollButton_Previews: PreviewProvider {
    static var previews: some View {
        PriceScrollButton()
    }
}
