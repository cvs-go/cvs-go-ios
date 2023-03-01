//
//  ReviewCell.swift
//  PyeonHae
//
//  Created by 정건호 on 2023/01/21.
//

import SwiftUI

struct ReviewCell: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            ReviewTextCell()
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
                    Image(name: .bookMark)
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
