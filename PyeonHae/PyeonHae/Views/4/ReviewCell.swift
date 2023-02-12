//
//  ReviewCell.swift
//  PyeonHae
//
//  Created by 정건호 on 2023/01/21.
//

import SwiftUI

struct ReviewCell: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("타이틀 제목이 들어갑니다.")
                .lineLimit(1)
                .font(.pretendard(.semiBold, 16))
                .foregroundColor(.grayscale100)
            HStack(spacing: 0) {
                ForEach(0..<5) { cell in
                    Image(name: .yellowStar)
                }
            }
            Text("후기 본문이 들어갑니다. 미리보기에서는 두줄이 들어가야할 것 같네요. 내용이 넘어간다면 이렇게 됩니다.후기 본문이 들어갑니다. 미리보기에서는 두줄이 들어가야할 것 같네요. 내용이 넘어간다면 이렇게 됩니다")
                .lineLimit(2)
                .font(.pretendard(.regular, 14))
                .foregroundColor(.grayscale70)
            HStack(spacing: 2) {
                Image(name: .like)
                Text("14245")
                    .font(.pretendard(.semiBold, 12))
                    .foregroundColor(.grayscale85)
            }
            .padding(EdgeInsets(top: 4, leading: 12, bottom: 4, trailing: 12))
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.grayscale30)
            )
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 10)
                HStack {
                    Spacer().frame(width: 6)
                    Image(name: .sampleImage)
                        .resizable()
                        .frame(width: 52, height: 52)
                    VStack(alignment: .leading) {
                        Text("코카콜라")
                            .font(.pretendard(.regular, 14))
                            .foregroundColor(.grayscale70)
                        Text("상품이름 한줄에서 끝내자")
                            .font(.pretendard(.semiBold, 14))
                            .foregroundColor(.grayscale85)
                    }
                    Spacer()
                    Image(name: .bookmark)
                    Spacer().frame(width: 13)
                }
            }
            .frame(height: 64)
            .foregroundColor(.white)
        }
        .padding(.horizontal, 12)
        .padding(.top, 10)
        .foregroundColor(Color.grayscale10)
    }
}

struct ReviewCell_Previews: PreviewProvider {
    static var previews: some View {
        ReviewCell()
    }
}
