//
//  LoginView.swift
//  PyeonHae
//
//  Created by 정건호 on 2022/12/25.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var loginViewModel = LoginViewModel()
    @FocusState private var isFocused
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer().frame(height: 120)
                Image(name: .pyeonHaeImage)
                Spacer()
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
                Spacer().frame(height: isFocused ? 30 : 10)
                if !isFocused {
                    VStack {
                        Text("계속하기")
                            .font(.pretendard(.bold, 18))
                            .foregroundColor(.white)
                            .frame(width: UIWindow().screen.bounds.width - 40, height: 50)
                            .background(backgroundColor)
                            .cornerRadius(10)
                            .onTapGesture {
                                loginViewModel.checkEmail()
                            }
                            .disabled(isDisabled)
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
                    Spacer()
                }
                Text("계속하기")
                    .font(.pretendard(.bold, 18))
                    .foregroundColor(.white)
                    .frame(width: UIWindow().screen.bounds.width, height: 50)
                    .background(backgroundColor)
                    .background(Color.red100)
                    .opacity(isFocused ? 1 : 0)
                    .onTapGesture {
                        loginViewModel.checkEmail()
                    }
                    .disabled(isDisabled)
                
                // 존재하는 이메일인 경우 로그인 화면으로 푸시
                NavigationLink(destination: InputPasswordView(loginViewModel: loginViewModel), isActive: $loginViewModel.pushToLogin) {
                    EmptyView()
                }
                // 존재하지 않는 이메일인 경우 회원가입 화면으로 푸시
                NavigationLink(destination: SignupPasswordView(loginViewModel: loginViewModel), isActive: $loginViewModel.pushToSignUp) {
                    EmptyView()
                }
            }
            .background(
                Image(name: .backgroundImage)
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
            )
            .onAppear {
                self.loginViewModel.textFieldType = .email
                self.loginViewModel.textFieldState = .normal
            }
            .onDisappear{
                self.isFocused = false
            }
        }
        .navigationViewStyle(.stack)
    }
    
    var backgroundColor: Color {
        return loginViewModel.textFieldState == .checkEmail
        || loginViewModel.email == String()
        ? Color.grayscale50
        : Color.red100
    }
    
    var isDisabled: Bool {
        return loginViewModel.textFieldState == .checkEmail
        || loginViewModel.email == String()
        ? true
        : false
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
