//
//  UserPageView.swift
//  PyeonHae
//
//  Created by 이주화 on 2023/02/08.
//

import SwiftUI

struct UserPageView: View {
    @ObservedObject var reviewViewModel: ReviewViewModel
    @Binding var selectedReviewerId: Int
    
    var body: some View {
        GeometryReader { geo in
            if reviewViewModel.userInfoLoading {
                LoadingView()
                    .position(x: geo.size.width/2, y: geo.size.height/2)
            } else {
                VStack {
                    NavigationBar(title: "회원 정보")
                    ScrollView {
                        UserInfoView(
                            userInfo: reviewViewModel.userInfo,
                            userInfoType: selectedReviewerId == UserShared.userId ? .me : .other,
                            tagMatchPercentage: reviewViewModel.tagMatchPercentage
                        )
                        Spacer().frame(height: 20)
                        WriteReviewsView(
                            reviewViewModel: reviewViewModel,
                            selectedReviewerId: $selectedReviewerId
                        )
                    }
                    .background(Color.grayscale10)
                }
            }
        }
        .onAppear {
            reviewViewModel.userInfoLoading = true
            reviewViewModel.requestSelectedUserInfo(userId: selectedReviewerId)
            reviewViewModel.requestUserReviewList(userId: selectedReviewerId)
        }
    }
}
