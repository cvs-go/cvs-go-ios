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
    @State var presentModal = false
    
    var body: some View {
        VStack {
            NavigationBar()
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
                    Text(attributedText())
                        .font(.pretendard(.regular, 12))
                        .foregroundColor(.grayscale85)
                    Spacer().frame(height: 8)
                    Text("자세히 보기")
                        .font(.pretendard(.medium, 12))
                        .foregroundColor(.iris100)
                        .underline()
                        .onTapGesture {
                            presentModal = true
                        }
                }
                .padding(EdgeInsets(top: 23, leading: 20, bottom: 0, trailing: 20))
            }
            NavigationLink(destination: SignupNicknameView(loginViewModel: loginViewModel)) {
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
            self.loginViewModel.textFieldType = .signupCheckPassword
            self.isFocused = true
        }
        .fullScreenCover(isPresented: $presentModal) {
            TermsAndPolicyView()
        }
    }
    var backgroundColor: Color {
        return loginViewModel.textFieldState == .differentPassword
        || loginViewModel.checkPassword.isEmpty
        ? Color.grayscale50
        : Color.red100
    }
    
    var isDisabled: Bool {
        return loginViewModel.textFieldState == .differentPassword
        || loginViewModel.checkPassword.isEmpty
        ? true
        : false
    }
    
    func attributedText() -> AttributedString {
        var fullText = AttributedString("‘다음’버튼을 누르시면 이용약관과 개인정보처리방침에 \n모두 동의한 것으로 간주합니다.")
        fullText.font = .pretendard(.regular, 12)
        fullText.foregroundColor = .grayscale85
        
        if let termsOfUseText = fullText.range(of: "이용약관") {
            fullText[termsOfUseText].font = .pretendard(.bold, 12)
        }
        if let privacyAndPolicy = fullText.range(of: "개인정보처리방침") {
            fullText[privacyAndPolicy].font = .pretendard(.bold, 12)
        }
        
        return fullText
    }
}
