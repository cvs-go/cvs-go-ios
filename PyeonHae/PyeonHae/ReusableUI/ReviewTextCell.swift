//
//  ReviewTextCell.swift
//  PyeonHae
//
//  Created by 이주화 on 2023/03/01.
//

import SwiftUI

struct ReviewTextCell: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
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
                .foregroundColor(.grayscale85)
                .padding(.vertical, 3)
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
        }
    }
}

struct ReviewTextCell_Previews: PreviewProvider {
    static var previews: some View {
        ReviewTextCell()
    }
}
