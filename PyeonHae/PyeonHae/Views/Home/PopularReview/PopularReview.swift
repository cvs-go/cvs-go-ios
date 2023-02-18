//
//  PopularReview.swift
//  PyeonHae
//
//  Created by 이주화 on 2023/01/26.
//

import SwiftUI

struct PopularReview: View {
    var body: some View {
        VStack {
            HStack {
                Spacer().frame(width: 20)
                Text("인기 리뷰")
                    .font(.pretendard(.bold, 18))
                    .foregroundColor(.grayscale100)
                Spacer()
                Image(name: .arrowRight)
                Spacer().frame(width: 16)
            }
            Spacer().frame(height: 16)
            ScrollView(.horizontal) {
                HStack {
                    ForEach(0..<10){ cell in
                        ReviewView()
                    }
                }
                .padding(.horizontal, 20)
            }
        }
        .padding(.vertical, 16)
        .background(Color.white)
    }
}

struct PopularReview_Previews: PreviewProvider {
    static var previews: some View {
        PopularReview()
    }
}
