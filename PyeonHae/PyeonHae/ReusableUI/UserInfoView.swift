//
//  UserInfoView.swift
//  PyeonHae
//
//  Created by 이주화 on 2023/02/08.
//

import SwiftUI
import Kingfisher

struct UserInfoView: View {
    private let userInfoType: UserInfoType
    @State var followCheck: Bool = false
    @Binding var showEditView: Bool
    
    init(
        userInfoType: UserInfoType,
        showEditView: Binding<Bool> = .constant(false)
    ) {
        self.userInfoType = userInfoType
        self._showEditView = showEditView
    }
    
    var body: some View {
        VStack {
            HStack(spacing: 16) {
                if let url = UserShared.userProfileImageUrl, let imageUrl = URL(string: url) {
                    KFImage(imageUrl)
                        .resizable()
                        .frame(width: 72, height: 72)
                        .cornerRadius(10)
                } else {
                    Image(name: .emptyImage)
                }
                VStack(alignment: .leading) {
                    HStack(spacing: 6) {
                        Text(UserShared.userNickname)
                            .font(.pretendard(.semiBold, 16))
                            .foregroundColor(.grayscale100)
                        Image(name: .editPen)
                            .hidden(userInfoType == .other)
                            .onTapGesture {
                                self.showEditView = true
                            }
                    }
                    HStack {
                        ForEach(UserShared.userTags, id: \.self) { tag in
                            Text("#\(tag.name)")
                                .font(.pretendard(.medium, 14))
                                .foregroundColor(.iris100)
                        }
                    }
                    HStack(spacing: 6) {
                        Image(name: userInfoType == .me ? .fillLike : .statistics)
                            .renderingMode(.template)
                            .foregroundColor(.grayscale70)
                        Text(userInfoType == .me ? "\(UserShared.userReviewLikeCount)명에게 도움을 줬어요." : "나와 취향이 66% 비슷해요.")
                            .font(.pretendard(.medium, 14))
                            .foregroundColor(.grayscale70)
                    }
                }
                .frame(height: 72)
                Spacer()
            }
            if userInfoType == .other {
                Group {
                    Spacer().frame(height: 22)
                    Button(action: {
                        followCheck.toggle()
                    }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                            Text("팔로우")
                                .font(.pretendard(.bold, 18))
                                .foregroundColor(.white)
                        }
                        .foregroundColor(followCheck ? Color.red100 : Color.grayscale50)
                    }
                    .frame(height: 49)
                }
            }
        }
        .padding(EdgeInsets(top: 0, leading: 20, bottom: 20, trailing: 20))
        .background(Color.white)
    }
}

enum UserInfoType {
    case me
    case other
}
