//
//  WriteReviews.swift
//  PyeonHae
//
//  Created by 이주화 on 2023/02/08.
//

import SwiftUI

struct WriteReviewsView: View {
    var body: some View {
        VStack {
            HStack {
                Text("작성한 리뷰")
                    .font(.pretendard(.semiBold, 20))
                    .foregroundColor(.grayscale100)
                Text("112")
                    .font(.pretendard(.semiBold, 20))
                    .foregroundColor(.red100)
                Spacer()
                Image(name: .fillLike)
                Text("14245명")
                    .font(.pretendard(.semiBold, 12))
                    .foregroundColor(.grayscale50)
            }
            VStack {
                ForEach(0..<10){ cell in
                    ReviewCell()
                        .padding(.bottom, 16)
                }
            }
        }
        .padding(.top, 14)
        .padding(.horizontal, 20)
        .background(Color.white)
    }
}

struct WriteReviews_Previews: PreviewProvider {
    static var previews: some View {
        WriteReviewsView()
    }
}
