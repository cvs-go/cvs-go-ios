//
//  SignupSelectTagView.swift
//  PyeonHae
//
//  Created by 정건호 on 2023/01/15.
//

import SwiftUI

struct SignupSelectTagView: View {
    @ObservedObject var loginViewModel: LoginViewModel
    var body: some View {
        VStack(alignment: .leading) {
            Spacer().frame(height: 23)
            Text("‘\(loginViewModel.nickname)’님의\n취향이 궁금해요.")
                .font(.pretendard(.medium, 24))
                .foregroundColor(.grayscale100)
            Spacer().frame(height: 8)
            Text("최대 3개까지 선택할 수 있습니다.")
                .font(.pretendard(.regular, 14))
                .foregroundColor(.grayscale85)
                .padding(.leading, 2)
            Spacer().frame(height: 31)
            Text("유저 태그")
                .font(.pretendard(.bold, 14))
                .foregroundColor(.grayscale100)
            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.leading, 20)
    }
}
