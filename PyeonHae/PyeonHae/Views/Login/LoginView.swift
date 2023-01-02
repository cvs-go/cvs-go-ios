//
//  LoginView.swift
//  PyeonHae
//
//  Created by 정건호 on 2022/12/25.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var loginViewModel = LoginViewModel()
//    @Binding var email: String
    @FocusState private var isFocused
//    @State var state: TextFieldState = .normal
    
//    init(email: Binding<String> = .constant(String())) {
//        self._email = email
//    }
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    // TODO: 추후 이미지 추가 예정
                    Text("대략적인 이미지 크기")
                        .frame(width: UIWindow().screen.bounds.width - 40, height: 300)
                    VStack {
                        TextFieldWithTitle(
                            text: $loginViewModel.email,
                            title: "아이디",
                            placeholder: "이메일을 입력해주세요.",
                            isSecure: false,
                            type: .email,
                            state: $loginViewModel.textFieldState
                        )
                        .focused($isFocused)
                        .padding(.horizontal, 20)
                        Spacer().frame(height: 10)
                        if !isFocused {
                            NavigationLink(destination: InputPasswordView(loginViewModel: loginViewModel)) {
                                Text("계속하기")
                                    .font(.pretendard(.bold, 18))
                                    .foregroundColor(.white)
                                    .frame(width: UIWindow().screen.bounds.width - 40, height: 50)
                                    .background(loginViewModel.textFieldState == .checkEmail
                                                || loginViewModel.email == String()
                                                ? Color.grayscale50
                                                : Color.red100
                                    )
                                    .cornerRadius(10)
                                
                            }
                            Spacer().frame(height: 29)
                            Text("간편 로그인")
                                .font(.pretendard(.bold, 14))
                                .foregroundColor(.grayscale100)
                            Spacer().frame(height: 20)
                            HStack(spacing: 16) {
                                Image(name: .kakaoLogin)
                                    .onTapGesture {
                                        print("kakaoLogin")
                                    }
                                Image(name: .naverLogin)
                                    .onTapGesture {
                                        print("naverLogin")
                                    }
                                Image(name: .appleLogin)
                                    .onTapGesture {
                                        print("appleLogin")
                                    }
                            }
                        }
                    }
                }
                NavigationLink(destination: InputPasswordView(loginViewModel: loginViewModel)) {
                    Text("계속하기")
                        .font(.pretendard(.bold, 18))
                        .foregroundColor(.white)
                        .frame(width: UIWindow().screen.bounds.width, height: 50)
                        .background(loginViewModel.textFieldState == .checkEmail
                                    || loginViewModel.email == String()
                                    ? Color.grayscale50
                                    : Color.red100
                        )
                        .opacity(isFocused ? 1 : 0)
                }
            }
        }
    }
}
