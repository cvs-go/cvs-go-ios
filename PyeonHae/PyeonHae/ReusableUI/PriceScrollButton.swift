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
    @State private var priceTemp: CGFloat = 0
    @State private var lastEditPrice: CGFloat = 0
    
    let trackWidth: CGFloat = 335
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Text("가격")
                    .font(.pretendard(.bold, 12))
                    .foregroundColor(Color.grayscale85)
                Spacer()
                if (minPrice == 0 && maxPrice == 1) {
                    Text("전체")
                        .font(.pretendard(.regular, 12))
                        .foregroundColor(Color.grayscale70)
                        .padding(.trailing, 20)
                } else {
                    Text("\(Int(minPrice * 15000))원~\(Int(maxPrice * 15000))원")
                        .font(.pretendard(.regular, 12))
                        .foregroundColor(Color.grayscale70)
                        .padding(.trailing, 20)
                }
            }
            ZStack {
                HStack(spacing: 0) {
                    Rectangle()
                        .foregroundColor(Color.grayscale30)
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
                        .padding(.leading, trackWidth * minPrice)
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    if priceTemp == 0 {
                                        lastEditPrice = minPrice
                                    }
                                    let addMinPrice = max(0, max(0, (minPrice * trackWidth + value.translation.width) / trackWidth) - priceTemp)
                                    if addMinPrice < maxPrice {
                                        minPrice = addMinPrice
                                    }
                                    priceTemp = minPrice - lastEditPrice
                                }
                                .onEnded { value in
                                    priceTemp = 0
                                }
                        )
                    Spacer().frame(width: max(trackWidth * (maxPrice - minPrice) - 32, 0))
                    Image(name: .PriceScrollButton)
                        .resizable()
                        .frame(width: 32, height: 32)
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    let newMaxPrice = min(1, (maxPrice * trackWidth + value.translation.width) / trackWidth)
                                    if newMaxPrice > minPrice {
                                        maxPrice = newMaxPrice
                                    }
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
