//
//  LoginViewModel.swift
//  PyeonHae
//
//  Created by 정건호 on 2023/01/02.
//

import Foundation
import Combine

class LoginViewModel: ObservableObject {
    @Published var textFieldState: TextFieldState = .normal
    @Published var email: String = String()
    @Published var password: String = String()
    var bag = Set<AnyCancellable>()
    
    init() {
        $email.sink { text in
            self.state(textFieldType: .email)
        }.store(in: &bag)
    }
    func state(textFieldType: TextFieldType) {
        switch textFieldType {
        case .email:
            if email.isValidEmail() || email.isEmpty {
                textFieldState = .normal
            } else {
                textFieldState = .checkEmail
            }
//        case .password:
//            if password.isValidPassword() || password.isEmpty {
//                textFieldState = .normal
//            } else {
//                textFieldState = .wrongPassword
//            }
        case .signupPassword:
            if password.isValidPassword() {
                textFieldState = .availablePassword
            } else {
                textFieldState = .checkPassword
            }
        default:
            textFieldState = .normal
        }
    }
    
    func checkEmail() -> Bool {
        // 존재하는 id인지 아닌지 판별하는 api
        if email == "dghj6739@naver.com" {
            return true
        } else {
            return false
        }
    }
}

enum TextFieldState: String {
    case normal = ""
    case checkEmail = "이메일 형식을 확인하세요."
    case wrongPassword = "정확한 비밀번호를 입력해주세요." // 틀린 비밀번호로 로그인 버튼 클릭 시
    case checkPassword = "영문+숫자+특수기호 포함 10자 이상만 가능합니다."
    case availablePassword = "사용할 수 있는 비밀번호입니다."
}
