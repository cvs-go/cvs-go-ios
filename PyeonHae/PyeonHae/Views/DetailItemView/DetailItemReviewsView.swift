//
//  DetailItemReviewsView.swift
//  PyeonHae
//
//  Created by 이주화 on 2023/03/01.
//

import SwiftUI

struct DetailItemReviewsView: View {
    var body: some View {
        VStack {
            HStack {
                Text("리뷰 145개")
                    .font(.pretendard(.semiBold, 16))
                    .foregroundColor(.grayscale100)
                Spacer()
                    Image(name: .redStar)
                        .resizable()
                        .frame(width: 16, height: 16)
                Text("4.5")
                    .font(.pretendard(.semiBold, 16))
                    .foregroundColor(.grayscale100)
            }
            .padding(.top, 12)
            .padding(.horizontal, 20)
            HStack {
                Spacer()
                HStack(spacing: 6) {
                    Text("최신순")
                        .font(.pretendard(.regular, 12))
                        .foregroundColor(.grayscale85)
                    Image(name: .invertedTriangle)
                }
                .frame(width: 64.5, height: 26)
                .background(Color.grayscale10)
                .cornerRadius(10)
            }
            .padding(.horizontal, 20)
            ForEach(0..<10) { _ in
                VStack {
                    ReviewUserInfo(reviewType: .normal)
                    ReviewTextCell()
                }
                .padding(.horizontal, 20)
                Color.grayscale30.opacity(0.5).frame(height: 1)
                    .padding(.bottom, 16)
            }
//            .padding(.top, 10)
            
        }
        
    }
}

struct DetailItemReviewsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailItemReviewsView()
    }
}
