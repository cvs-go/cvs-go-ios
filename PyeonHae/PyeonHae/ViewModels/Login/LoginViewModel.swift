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
        case .password:
            if password.isValidPassword() || password.isEmpty {
                textFieldState = .normal
            } else {
                textFieldState = .checkPassword
            }
        default:
            textFieldState = .normal
        }
    }
}

enum TextFieldState: String {
    case normal = ""
    case checkEmail = "이메일 형식을 확인하세요."
    case checkPassword = "정확한 비밀번호를 입력해주세요."
}
