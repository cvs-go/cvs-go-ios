//
//  SignupCheckPasswordView.swift
//  PyeonHae
//
//  Created by 정건호 on 2023/01/07.
//

import SwiftUI

struct SignupCheckPasswordView: View {
    @ObservedObject var loginViewModel: LoginViewModel
    @FocusState private var isFocused
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading) {
                    Text("입력한 비밀번호를\n입력해주세요.")
                        .font(.pretendard(.medium, 24))
                        .foregroundColor(.grayscale100)
                    Spacer().frame(height: 56)
                    TextFieldWithTitle(
                        text: $loginViewModel.checkPassword,
                        title: "비밀번호 확인",
                        placeholder: "비밀번호를 입력해주세요.",
                        isSecure: true,
                        type: .signupCheckPassword,
                        state: $loginViewModel.textFieldState
                    )
                    .focused($isFocused)
                    Spacer().frame(height: 17)
                    Text("‘다음’버튼을 누르시면 이용약관과 개인정보처리방침에 \n모두 동의한 것으로 간주합니다.")
                        .font(.pretendard(.regular, 12))
                        .foregroundColor(.grayscale85)
                }
                .padding(EdgeInsets(top: 23, leading: 20, bottom: 0, trailing: 20))
            }
            Text("다음")
                .font(.pretendard(.bold, 18))
                .foregroundColor(.white)
                .frame(width: UIWindow().screen.bounds.width - (isFocused ? 0 : 40), height: 50)
                .background(Color.red100)
                .cornerRadius(isFocused ? 0 : 10)
            Spacer().frame(height: isFocused ? 0 : 52)
        }
        .onAppear {
            self.loginViewModel.textFieldType = .signupCheckPassword
        }
    }
//
//    var attributedString: AttributedString {
//        var fullString: AttributedString = "‘다음’버튼을 누르시면 이용약관과 개인정보처리방침에 \n모두 동의한 것으로 간주합니다."
//        var privacyAndPolicy: AttributedString = "개인정보처리방침"
//        fullString.font = .pretendard(.regular, 14)
//        let font = AttributeContainer.font(.pretendard(.medium, 14))
//        fullString.replaceAttributes(termsOfUse, with: font)
//        fullString.replaceAttributes(privacyAndPolicy, with: font)
//    }
}
