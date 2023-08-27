//
//  UserSettingView.swift
//  PyeonHae
//
//  Created by 이주화 on 2023/05/18.
//

import SwiftUI

struct UserSettingView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var myInfoViewModel: MyInfoViewModel
    
    @State private var isOn = false
    
    // TODO: 얼럿 취소할 시에 MyInfoView로 pop 되는 버그 수정하기
    @State private var showLogoutAlert = false
    
    var body: some View {
        VStack {
            settingTopBar
            VStack(alignment: .leading, spacing: 0) {
                titleView("서비스")
                contentsView("공지사항", completion: {
                    myInfoViewModel.requestNoticeList()
                })
            }
            divider(height: 1)
            VStack(alignment: .leading, spacing: 0) {
                titleView("앱 정보")
                contentsView("오픈 라이센스", completion: {
                    // Action
                })
                contentsView("현재 버전 0.00.1", arrowHidden: true)
            }
            divider(height: 14)
            contentsView("로그아웃", color: .grayscale50, arrowHidden: true, completion: {
                showLogoutAlert = true
            })
            contentsView("회원탈퇴", color: .grayscale50, arrowHidden: true)
            divider(height: .infinity)
        }
        .showDestructiveAlert(
            title: "로그아웃 하시겠습니까?",
            secondaryButtonText: "로그아웃",
            showAlert: $showLogoutAlert,
            destructiveAction: {
                myInfoViewModel.requestLogout()
                switchRootView(rootview: LoginView())
            }
        )
        .edgesIgnoringSafeArea(.bottom)
    }
    
    var settingTopBar: some View {
        HStack(spacing: 0) {
            Spacer().frame(width: 14)
            Image(name: .arrowLeft)
                .onTapGesture {
                    self.presentationMode.wrappedValue.dismiss()
                }
            Spacer().frame(width: 9)
            Text("설정")
                .font(.pretendard(.bold, 18))
                .foregroundColor(.black)
            Spacer()
        }
        .frame(height: 44)
    }
    
    @ViewBuilder
    func titleView(_ text: String) -> some View {
        Text(text)
            .font(.pretendard(.medium, 12))
            .foregroundColor(.mineGray400)
            .frame(height: 28)
            .padding(.horizontal, 24)
    }
    
    @ViewBuilder
    func contentsView(
        _ text: String,
        color: Color = .mineGray900,
        arrowHidden: Bool = false,
        completion: (() -> Void)? = nil
    ) -> some View {
        Button(action: {
            completion?()
        }) {
            HStack {
                Text(text)
                    .font(.pretendard(.medium, 16))
                    .foregroundColor(color)
                Spacer()
                Image(name: .arrowRight)
                    .hidden(arrowHidden)
            }
        }
        .padding(.horizontal, 24)
        .frame(height: 40)
    }
    
    func divider(height: CGFloat) -> some View {
        Rectangle().foregroundColor(.grayscale20).frame(maxHeight: height)
    }
}
