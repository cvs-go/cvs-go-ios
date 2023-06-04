//
//  PriceScrollButton.swift
//  PyeonHae
//
//  Created by 이주화 on 2023/05/01.
//

import SwiftUI

struct PriceScrollButton: View {
    
    @Binding var minPrice: CGFloat
    @Binding var maxPrice: CGFloat
    @State private var priceTemp: CGFloat = 0
    @State private var lastEditPrice: CGFloat = 0
    let highestPrice: Int
    
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
                        Text("\(Int(minPrice * CGFloat(highestPrice)) / 100 * 100)원~\(Int(maxPrice * CGFloat(highestPrice)) / 100 * 100)원")
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
                                //이동한 값을 통해 제스처가 종료된 이후에 값 변경을 할 시 화면이 변경되지 않고, 제스처 중에 그대로 값 변경을 하게 될 경우 에러가 발생하여 최초값으로 부터 이동한 정도를 계속 계산하는 로직입니다.
                                    .onChanged { value in
                                        if priceTemp == 0 {
                                            lastEditPrice = minPrice //최초값 저장
                                        }
                                        let addMinPrice = max(0, (minPrice * trackWidth + value.translation.width) / trackWidth - priceTemp) // 이번에 들어온 제스처로 부터 직전보다 이동한 거리 계산
                                        if addMinPrice < maxPrice - (64 / trackWidth) { //최댓값보다 더 많이 이동하지 않았는지 확인
                                            minPrice = addMinPrice
                                        } else {
                                            minPrice = maxPrice - (64 / trackWidth)
                                        }
                                        priceTemp = minPrice - lastEditPrice //지금까지 이동한 거리 저장
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
                    Text("\(Int(highestPrice * 1/3) / 100 * 100)원")
                        .font(.pretendard(.regular, 12))
                        .foregroundColor(Color.grayscale70)
                    Spacer()
                    Text("\(Int(highestPrice * 2/3) / 100 * 100)원")
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

