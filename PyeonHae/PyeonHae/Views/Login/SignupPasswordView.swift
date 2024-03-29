//
//  SignupPasswordView.swift
//  PyeonHae
//
//  Created by koochowon on 2023/01/04.
//

import SwiftUI

struct SignupPasswordView: View {
    @ObservedObject var loginViewModel: LoginViewModel
    @FocusState private var isFocused
    
    var body: some View {
        VStack {
            NavigationBar()
            ScrollView {
                VStack(alignment: .leading) {
                    Text("비밀번호를\n입력해주세요.")
                        .font(.pretendard(.medium, 24))
                        .foregroundColor(.grayscale100)
                    Spacer().frame(height: 8)
                    Text("‘\(loginViewModel.email)’로 서비스에 가입합니다.")
                        .font(.pretendard(.regular, 14))
                        .foregroundColor(.grayscale85)
                        .padding(.leading, 2)
                    Spacer().frame(height: 31)
                    TextFieldWithTitle(
                        text: $loginViewModel.password,
                        title: "비밀번호 확인",
                        placeholder: "영문+숫자+특수기호 포함 10자 이상",
                        isSecure: true,
                        type: .signupPassword,
                        state: $loginViewModel.textFieldState
                    )
                    .focused($isFocused)
                    Spacer()
                }
                .padding(EdgeInsets(top: 23, leading: 20, bottom: 0, trailing: 20))
            }
            NavigationLink(destination: SignupCheckPasswordView(loginViewModel: loginViewModel)) {
                Text("다음")
                    .font(.pretendard(.bold, 18))
                    .foregroundColor(.white)
                    .frame(width: UIWindow().screen.bounds.width - (isFocused ? 0 : 40), height: 50)
                    .background(backgroundColor)
                    .cornerRadius(isFocused ? 0 : 10)
            }
            .disabled(isDisabled)
            Spacer().frame(height: isFocused ? 0 : 52)
        }
        .onAppear {
            self.isFocused = true
            self.loginViewModel.textFieldType = .signupPassword
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
