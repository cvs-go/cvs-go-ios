//
//  ReviewUserInfo.swift
//  PyeonHae
//
//  Created by 정건호 on 2023/02/12.
//

import SwiftUI
import Kingfisher

struct ReviewUserInfo: View {
    let reviewType: ReviewType
    let profileUrl: String?
    let nickname: String
    let tags: [String]
    
    var body: some View {
        HStack(alignment: .center) {
            // 사용자 프로필 이미지
            if let profileUrl = profileUrl, let url = URL(string: profileUrl) {
                KFImage(url)
                    .resizable()
                    .frame(width: 36, height: 36)
                    .cornerRadius(100)
            } else {
                Image(name: .defalutUserImage)
                    .resizable()    
                    .frame(width: 36, height: 36)
                    .cornerRadius(100)
            }
            VStack(alignment: .leading) {
                Text(nickname)
                    .font(.pretendard(.semiBold, 14))
                    .foregroundColor(.grayscale100)
                HStack {
                    ForEach(tags, id: \.self){ tag in
                        Text("#\(tag)")
                            .font(.pretendard(.medium, 12))
                            .foregroundColor(.iris100)
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

enum ReviewType {
    case normal
    case popular
}
