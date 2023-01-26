//
//  ReviewCell.swift
//  PyeonHae
//
//  Created by 정건호 on 2023/01/21.
//

import SwiftUI

struct ReviewCell: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
            VStack(alignment: .leading) {
                HStack {
                    Circle()
                        .fill(Color.grayscale30)
                        .frame(width: 36, height: 36)
                    VStack(alignment: .leading) {
                        Text("작성자 닉네임")
                            .font(.pretendard(.semiBold, 14))
                            .foregroundColor(.grayscale100)
                        HStack {
                            ForEach(0..<3){ cell in
                                Text("#매른이")
                                    .font(.pretendard(.medium, 12))
                                    .foregroundColor(.red100)
                            }
                        }
                    }
                }
                .padding(.top, 10)
                Text("타이틀 제목이 들어갑니다.")
                    .lineLimit(1)
                    .font(.pretendard(.semiBold, 16))
                    .foregroundColor(.grayscale100)
                    .padding(.top, 17)
                HStack {
                    ForEach(0..<5) { cell in
                        Image(name: .star)
                    }
                }
                Text("후기 본문이 들어갑니다. 미리보기에서는 두줄이 들어가야할 것 같네요. 내용이 넘어간다면 이렇게 됩니다.후기 본문이 들어갑니다. 미리보기에서는 두줄이 들어가야할 것 같네요. 내용이 넘어간다면 이렇게 됩니다")
                    .lineLimit(2)
                    .font(.pretendard(.regular, 14))
                    .foregroundColor(.grayscale70)
                HStack {
                    Image(name: .close)
                        .frame(width: 12, height: 12)
                    Text("14245명이 도움을 받았어요.")
                        .font(.pretendard(.semiBold, 12))
                        .foregroundColor(.grayscale85)
                }
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 10)
                    HStack {
                        Image(name: .sampleImage)
                            .resizable()
                            .frame(width: 52, height: 52)
                        VStack(alignment: .leading) {
                            Text("코카콜라")
                                .font(.pretendard(.regular, 14))
                                .foregroundColor(.grayscale70)
                            Text("상품이름 한줄에서 끝내자")
                                .font(.pretendard(.regular, 14))
                                .foregroundColor(.grayscale70)
                        }
                    }
                }
                .foregroundColor(.white)
                .padding(.bottom, 13)
            }
            .padding(.horizontal, 12)
        }
        .foregroundColor(Color.grayscale10)
        .frame(width: 310, height: 264)
    }
}

struct ReviewCell_Previews: PreviewProvider {
    static var previews: some View {
        ReviewCell()
    }
}
