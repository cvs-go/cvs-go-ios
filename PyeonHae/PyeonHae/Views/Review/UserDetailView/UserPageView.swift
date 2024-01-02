//
//  UserPageView.swift
//  PyeonHae
//
//  Created by 이주화 on 2023/02/08.
//

import SwiftUI

struct UserPageView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var reviewViewModel: ReviewViewModel
    
    @Binding var selectedReviewerId: Int
    
    var body: some View {
        GeometryReader { geo in
            if reviewViewModel.userInfoLoading {
                LoadingView()
                    .position(x: geo.size.width/2, y: geo.size.height/2)
            } else {
                VStack {
                    userPageTopBar
                    ScrollView {
                        UserInfoView(
                            userInfo: reviewViewModel.userInfo,
                            userInfoType: selectedReviewerId == UserShared.userId ? .me : .other,
                            tagMatchPercentage: reviewViewModel.tagMatchPercentage
                        )
                        Spacer().frame(height: 20)
                        WriteReviewsView(userReviews: $reviewViewModel.userReviews)
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
    
    var userPageTopBar: some View {
        HStack(spacing: 0) {
            Spacer().frame(width: 14)
            Image(name: .arrowLeft)
                .onTapGesture {
                    self.presentationMode.wrappedValue.dismiss()
                }
            Spacer().frame(width: 9)
            Text("회원 정보")
                .font(.pretendard(.bold, 20))
                .foregroundColor(.grayscale100)
            Spacer()
        }
        .frame(height: 44)
    }
}
