//
//  ReviewUserInfo.swift
//  PyeonHae
//
//  Created by 정건호 on 2023/02/12.
//

import SwiftUI

struct ReviewUserInfo: View {
    let reviewType: ReviewType
    
    var body: some View {
        HStack(alignment: .center) {
            // 사용자 프로필 이미지
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
                            .foregroundColor(
                                reviewType == .normal
                                ? .iris100
                                : .red100
                            )
                    }
                }
            }
            Spacer()
            
            if reviewType == .normal {
                Text("팔로우")
                    .font(.pretendard(.semiBold, 12))
                    .padding(EdgeInsets(top: 6, leading: 20, bottom: 6, trailing: 20))
                    .background(Color.red100)
                    .cornerRadius(6)
                Spacer().frame(width: 12)
            }
        }
        .frame(height: 55)
        .foregroundColor(Color.grayscale10)
        .padding(.leading, 12)
        .background(Color.grayscale10)
        .cornerRadius(10)
    }
}

struct ReviewUserInfo_Previews: PreviewProvider {
    static var previews: some View {
        ReviewUserInfo(reviewType: .normal)
    }
}

enum ReviewType {
    case normal
    case popular
}
