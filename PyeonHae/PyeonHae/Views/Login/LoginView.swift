//
//  LoginView.swift
//  PyeonHae
//
//  Created by 정건호 on 2022/12/25.
//

import SwiftUI

struct LoginView: View {
    @FocusState private var isFocused
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    // TODO: 추후 이미지 추가 예정
                    Text("대략적인 이미지 크기")
                        .frame(width: UIWindow().screen.bounds.width - 40, height: 300)
                    VStack {
                        TextFieldWithTitle(
                            title: "아이디",
                            placeholder: "이메일을 입력해주세요.",
                            isSecure: false,
                            type: .email
                        )
                        .focused($isFocused)
                        .padding(.horizontal, 20)
                        Spacer().frame(height: 10)
                        if !isFocused {
                            NavigationLink(destination: InputPasswordView()) {
                                Text("계속하기")
                                    .font(.pretendard(.bold, 18))
                                    .foregroundColor(.white)
                                    .frame(width: UIWindow().screen.bounds.width - 40, height: 50)
                                    .background(Color.red100)
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
                NavigationLink(destination: InputPasswordView()) {
                    Text("계속하기")
                        .font(.pretendard(.bold, 18))
                        .foregroundColor(.white)
                        .frame(width: UIWindow().screen.bounds.width, height: 50)
                        .background(Color.red100)
                        .opacity(isFocused ? 1 : 0)
                }
            }
        }
    }
}
