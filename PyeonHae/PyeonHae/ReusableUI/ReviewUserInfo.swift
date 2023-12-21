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
    let isMe: Bool
    let isFollowing: Bool
    let followAction: () -> Void
    let unfollowAction: () -> Void
    let reviewerId: Int
    
    @State private var isFollowingValue: Bool
    @Binding var showUserPage: Bool
    @Binding var selectedReviewerId: Int
    
    init(
        reviewType: ReviewType,
        profileUrl: String?,
        nickname: String,
        tags: [String],
        isMe: Bool,
        isFollowing: Bool,
        followAction: @escaping () -> Void = {},
        unfollowAction: @escaping () -> Void = {},
        reviewerId: Int,
        showUserPage: Binding<Bool> = .constant(false),
        selectedReviewerId: Binding<Int> = .constant(-1)
    ) {
        self.reviewType = reviewType
        self.profileUrl = profileUrl
        self.nickname = nickname
        self.tags = tags
        self.isMe = isMe
        self.isFollowing = isFollowing
        self.followAction = followAction
        self.unfollowAction = unfollowAction
        self.reviewerId = reviewerId
        self._showUserPage = showUserPage
        self._selectedReviewerId = selectedReviewerId
        
        _isFollowingValue = State(initialValue: isFollowing)
    }
    
    var body: some View {
        HStack(alignment: .center) {
            Spacer().frame(width: 12)
            Group {
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
            }
            .onTapGesture {
                self.showUserPage = true
                self.selectedReviewerId = reviewerId
            }
            Spacer()
            
            if reviewType == .normal && !isMe {
                Text(isFollowingValue ? "팔로잉" : "팔로우")
                    .font(.pretendard(.semiBold, 12))
                    .padding(EdgeInsets(top: 6, leading: 20, bottom: 6, trailing: 20))
                    .background(isFollowingValue ? Color.grayscale50 : Color.red100)
                    .cornerRadius(6)
                    .onTapGesture {
                        isFollowingValue ? unfollowAction() : followAction()
                        isFollowingValue.toggle()
                    }
                Spacer().frame(width: 12)
            }
        }
        .frame(height: 55)
        .foregroundColor(Color.grayscale10)
        .background(Color.grayscale10)
        .cornerRadius(10)
        .padding(.init(top: 0, leading: 19, bottom: 0, trailing: reviewType == .normal ? 19 : 0))
    }
}

enum ReviewType {
    case normal
    case popular
}
