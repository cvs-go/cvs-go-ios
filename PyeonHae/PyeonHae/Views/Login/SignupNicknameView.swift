//
//  SignupNicknameView.swift
//  PyeonHae
//
//  Created by 정건호 on 2023/01/08.
//

import SwiftUI

struct SignupNicknameView: View {
    @ObservedObject var loginViewModel: LoginViewModel
    @FocusState private var isFocused
    
    var body: some View {
        VStack {
            NavigationBar()
            ScrollView {
                VStack(alignment: .leading) {
                    Text("사용할 닉네임을\n입력해 주세요.")
                        .font(.pretendard(.medium, 24))
                        .foregroundColor(.grayscale100)
                    Spacer().frame(height: 56)
                    TextFieldWithTitle(
                        text: $loginViewModel.nickname,
                        title: "닉네임",
                        placeholder: "2자 이상 8자 이내의 닉네임을 입력해주세요.",
                        isSecure: false,
                        type: .nickname,
                        state: $loginViewModel.textFieldState
                    )
                    .focused($isFocused)
                    Spacer()
                }
                .padding(EdgeInsets(top: 23, leading: 20, bottom: 0, trailing: 20))
            }
            
            NavigationLink(
                destination: SignupSelectTagView(loginViewModel: loginViewModel),
                isActive: $loginViewModel.checkNicknameValue
            ) {
                Text("다음")
                    .font(.pretendard(.bold, 18))
                    .foregroundColor(.white)
                    .frame(width: UIWindow().screen.bounds.width - (isFocused ? 0 : 40), height: 50)
                    .background(backgroundColor)
                    .cornerRadius(isFocused ? 0 : 10)
                    .onTapGesture {
                        loginViewModel.checkNickname()
                    }
            }
            .disabled(isDisabled)
            Spacer().frame(height: isFocused ? 0 : 52)
        }
        .onAppear {
            self.isFocused = true
            self.loginViewModel.textFieldType = .nickname
        }
    }
    var backgroundColor: Color {
        return 2 <= loginViewModel.nickname.count && loginViewModel.nickname.count < 8
        ? Color.red100
        : Color.grayscale50
    }
    
    var isDisabled: Bool {
        return 2 <= loginViewModel.nickname.count && loginViewModel.nickname.count < 8
        ? false
        : true
    }
}
