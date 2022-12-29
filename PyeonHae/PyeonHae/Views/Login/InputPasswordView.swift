//
//  InputPasswordView.swift
//  PyeonHae
//
//  Created by 정건호 on 2022/12/27.
//

import SwiftUI

struct InputPasswordView: View {
    @FocusState private var isFocused
    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading) {
                    Text("비밀번호를\n입력해주세요.")
                        .font(.pretendard(.medium, 24))
                        .foregroundColor(.grayscale100)
                    Spacer().frame(height: 8)
                    Text("‘사용자 아이디@gmail.com’로 로그인합니다.")
                        .font(.pretendard(.regular, 14))
                        .foregroundColor(.grayscale85)
                        .padding(.leading, 2)
                    Spacer().frame(height: 31)
                    TextFieldWithTitle(
                        title: "비밀번호",
                        placeholder: "비밀번호를 입력해주세요.",
                        isSecure: true
                    )
                    .focused($isFocused)
                    Spacer()
                }
                .padding(EdgeInsets(top: 23, leading: 20, bottom: 0, trailing: 20))
            }
        }
        Text("로그인")
            .font(.pretendard(.bold, 18))
            .foregroundColor(.white)
            .frame(width: UIWindow().screen.bounds.width - (isFocused ? 0 : 40), height: 50)
            .background(Color.red100)
            .cornerRadius(isFocused ? 0 : 10)
        Spacer().frame(height: isFocused ? 0 : 52)
    }
}
