//
//  ReviewView.swift
//  PyeonHae
//
//  Created by 이주화 on 2023/02/08.
//

import SwiftUI

struct ReviewView: View {
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
                .padding(.horizontal, 12)
                .padding(.top, 10)
                ReviewCell()
            }
        }
        .foregroundColor(Color.grayscale10)
        .frame(width: 310, height: 264)
    }
}

struct ReviewView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewView()
    }
}
