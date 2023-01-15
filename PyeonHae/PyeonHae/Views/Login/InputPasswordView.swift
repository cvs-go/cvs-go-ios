//
//  InputPasswordView.swift
//  PyeonHae
//
//  Created by 정건호 on 2022/12/27.
//

import SwiftUI

struct InputPasswordView: View {
    @ObservedObject var loginViewModel: LoginViewModel
    @FocusState private var isFocused
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading) {
                    Text("비밀번호를\n입력해주세요.")
                        .font(.pretendard(.medium, 24))
                        .foregroundColor(.grayscale100)
                    Spacer().frame(height: 8)
                    Text("‘\(loginViewModel.email)’로 로그인합니다.")
                        .font(.pretendard(.regular, 14))
                        .foregroundColor(.grayscale85)
                        .padding(.leading, 2)
                    Spacer().frame(height: 31)
                    TextFieldWithTitle(
                        text: $loginViewModel.password,
                        title: "비밀번호",
                        placeholder: "비밀번호를 입력해주세요.",
                        isSecure: true,
                        type: .loginPassword,
                        state: $loginViewModel.textFieldState
                    )
                    .focused($isFocused)
                    Spacer()
                }
                .padding(EdgeInsets(top: 23, leading: 20, bottom: 0, trailing: 20))
            }
            Text("로그인")
                .font(.pretendard(.bold, 18))
                .foregroundColor(.white)
                .frame(width: UIWindow().screen.bounds.width - (isFocused ? 0 : 40), height: 50)
                .background(backgroundColor)
                .cornerRadius(isFocused ? 0 : 10)
                .disabled(isDisabled)
                .onTapGesture {
                    // TODO: 로그인 성공 시, 화면 전환 어떻게 할지 의논해보기
                    loginViewModel.tryToLogin()
                }
            Spacer().frame(height: isFocused ? 0 : 52)
        }
        .onAppear {
            self.loginViewModel.textFieldType = .loginPassword
            self.isFocused = true
        }
        .onDisappear {
            self.loginViewModel.textFieldType = .email
        }
    }
    
    var backgroundColor: Color {
        return loginViewModel.password.isValidPassword()
        ? Color.red100
        : Color.grayscale50
    }
    
    var isDisabled: Bool {
        return loginViewModel.password.isValidPassword()
        ? false
        : true
    }
}
