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
                // TODO: 추후 이미지 추가 예정
                Text("대략적인 이미지 크기")
                    .frame(width: UIWindow().screen.bounds.width - 40, height: 300)
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
                    VStack {
                        NavigationLink(destination: getDestination) {
                            Text("계속하기")
                                .font(.pretendard(.bold, 18))
                                .foregroundColor(.white)
                                .frame(width: UIWindow().screen.bounds.width - 40, height: 50)
                                .background(backgroundColor)
                                .cornerRadius(10)
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
                }
                Spacer()
                NavigationLink(destination: getDestination) {
                    Text("계속하기")
                        .font(.pretendard(.bold, 18))
                        .foregroundColor(.white)
                        .frame(width: UIWindow().screen.bounds.width, height: 50)
                        .background(backgroundColor)
                        .background(Color.red100)
                        .opacity(isFocused ? 1 : 0)
                }
                .disabled(isDisabled)
            }
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
    
    func getDestination() -> AnyView {
        if loginViewModel.checkEmail() {
            return AnyView(InputPasswordView(loginViewModel: loginViewModel))
        } else {
            return AnyView(SignupPasswordView(loginViewModel: loginViewModel))
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
