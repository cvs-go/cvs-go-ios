//
//  SearchResultItemView.swift
//  PyeonHae
//
//  Created by 이주화 on 2023/02/21.
//

import SwiftUI

struct SearchResultItemView: View {
    @State var isBookMark: Bool = false
    @State var isHeartMark: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                ZStack {
                    Image(name: .sampleImage)
                        .resizable()
                        .frame(width: 120, height: 120)
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.grayscale30, lineWidth: 1)
                }
                .frame(width: 120, height: 120)
                VStack(alignment: .leading, spacing: 0) {
                    Text("롯데푸드")
                        .font(.pretendard(.regular, 12))
                        .foregroundColor(.grayscale70)
                    HStack {
                        Text("월드콘")
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
                    Text("2,500원")
                        .font(.pretendard(.medium, 16))
                        .foregroundColor(.grayscale85)
                        .padding(.bottom, 8)
                    HStack {
                        Image(name: .redStar)
                        Text("4.5")
                            .font(.pretendard(.semiBold, 14))
                            .foregroundColor(.grayscale100)
                        Text("|")
                            .font(.pretendard(.semiBold, 14))
                            .foregroundColor(.grayscale30)
                        Text("5,000개의 리뷰")
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
    }
}

struct SearchResultItemView_Previews: PreviewProvider {
    static var previews: some View {
        SearchResultItemView()
    }
}
