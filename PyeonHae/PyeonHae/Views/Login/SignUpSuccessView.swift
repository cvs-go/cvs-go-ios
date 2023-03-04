//
//  SignUpSuccessView.swift
//  PyeonHae
//
//  Created by 정건호 on 2023/03/03.
//

import SwiftUI

struct SignUpSuccessView: View {
    @ObservedObject var loginViewModel: LoginViewModel
    
    var body: some View {
        VStack {
            Spacer().frame(height: 73)
            HStack {
                Text("안녕하세요 '\(loginViewModel.nickname)'님!\n회원가입을 축하드려요.")
                    .font(.pretendard(.medium, 24))
                    .foregroundColor(.grayscale100)
                    .padding(.leading, 20)
                Spacer()
            }
            Spacer()
            Text("확인")
                .font(.pretendard(.bold, 18))
                .foregroundColor(.white)
                .frame(width: UIWindow().screen.bounds.width - 40, height: 50)
                .background(Color.red100)
                .cornerRadius(10)
                .onTapGesture {
                    loginViewModel.tryToLogin()
                }
        }
    }
}
