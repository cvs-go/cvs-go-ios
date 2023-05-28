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
        GeometryReader { geometry in
            let trackWidth = geometry.size.width
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
                    } else {
                        Text("\(Int(minPrice * 15000))원~\(Int(maxPrice * 15000))원")
                            .font(.pretendard(.regular, 12))
                            .foregroundColor(Color.grayscale70)
                    }
                }
                ZStack {
                    HStack(spacing: 0) {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(minPrice > 0 ? Color.grayscale30 : Color.grayscale100)
                            .frame(width: trackWidth * minPrice + 16, height: 8)
                        Rectangle()
                            .foregroundColor(Color.grayscale100)
                            .frame(width: trackWidth * (maxPrice - minPrice) - 32, height: 8)
                        RoundedRectangle(cornerRadius: 10)
                            .fill(maxPrice < 1 ? Color.grayscale30 : Color.grayscale100)
                            .frame(width: trackWidth * (1 - maxPrice) + 16, height: 8)
                    }

                    HStack(spacing: 0) {
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
                                        let addMinPrice = max(0, (minPrice * trackWidth + value.translation.width) / trackWidth - priceTemp)
                                        if addMinPrice < maxPrice - (64 / trackWidth) {
                                            minPrice = addMinPrice
                                        } else {
                                            minPrice = maxPrice - (64 / trackWidth)
                                        }
                                        priceTemp = minPrice - lastEditPrice
                                    }
                                    .onEnded { value in
                                        priceTemp = 0
                                    }
                            )
                        Spacer().frame(width: max(trackWidth * (maxPrice - minPrice) - 64, 0))
                        Image(name: .PriceScrollButton)
                            .resizable()
                            .frame(width: 32, height: 32)
                            .gesture(
                                DragGesture()
                                    .onChanged { value in
                                        let newMaxPrice = min(1, (maxPrice * trackWidth + value.translation.width) / trackWidth)
                                        if newMaxPrice > minPrice + (64 / trackWidth) {
                                            maxPrice = newMaxPrice
                                        } else {
                                            maxPrice = minPrice + (64 / trackWidth)
                                        }
                                    }
                            )
                        Spacer().frame(width: max(trackWidth * (1 - maxPrice), 0))
                    }
                }
                HStack {
                    Text("최소")
                        .font(.pretendard(.regular, 12))
                        .foregroundColor(Color.grayscale70)
                    Spacer()
                    Text("5천")
                        .font(.pretendard(.regular, 12))
                        .foregroundColor(Color.grayscale70)
                    Spacer()
                    Text("1만")
                        .font(.pretendard(.regular, 12))
                        .foregroundColor(Color.grayscale70)
                    Spacer()
                    Text("최대")
                        .font(.pretendard(.regular, 12))
                        .foregroundColor(Color.grayscale70)
                }
            }
        }
    }
}

struct PriceScrollButton_Previews: PreviewProvider {
    static var previews: some View {
        PriceScrollButton()
    }
}
