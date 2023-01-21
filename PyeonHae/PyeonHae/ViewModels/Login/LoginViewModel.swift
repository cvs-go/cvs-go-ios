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
    @Published var textFieldType: TextFieldType = .email
    @Published var email: String = String()
    @Published var password: String = String()
    @Published var checkPassword: String = String()
    @Published var nickname: String = String()
    
    var bag = Set<AnyCancellable>()
    
    init() {
        $email
            .filter { _ in self.textFieldType == .email }
            .sink { text in
                self.state(textFieldType: self.textFieldType)
        }.store(in: &bag)
        
        $password
            .sink { text in
                if self.textFieldType == .loginPassword {
                    self.textFieldState = .normal
                } else {
                    self.state(textFieldType: self.textFieldType)
                }
        }.store(in: &bag)
        
        $checkPassword
            .filter { _ in self.textFieldType == .signupCheckPassword }
            .sink { text in
                self.state(textFieldType: self.textFieldType)
            }.store(in: &bag)
        
        $nickname
            .filter { _ in self.textFieldType == .nickname }
            .sink { text in
                self.textFieldState = .normal
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
        case .loginPassword:
            break
        case .signupPassword:
            if password.isEmpty {
                textFieldState = .normal
            } else if password.isValidPassword() {
                textFieldState = .availablePassword
            } else {
                textFieldState = .checkPassword
            }
        case .signupCheckPassword:
            if checkPassword.isEmpty {
                textFieldState = .normal
            } else if password == checkPassword {
                textFieldState = .normal
            } else {
                textFieldState = .differentPassword
            }
        case .nickname:
            break
        }
    }
    
    // 존재하는 id인지 아닌지 판별하는 api
    func checkEmail() -> Bool {
        if email == "dghj6739@naver.com" {
            return true
        } else {
            return false
        }
    }
    
    // 닉네임 중복 검사 api
    func checkNickname() -> Bool {
        if nickname == "정건호" { // 중복된 닉네임이 있으면 false 던지고 텍스트필드 state 변경
            self.textFieldState = .unavailableNickname
            return false
        } else { // 없으면 true 던지고 다음 페이지로
            return true
        }
    }
    
    // 비밀번호 검사하는 api
    func tryToLogin() -> Bool {
        if password == "wnghkrjsgh12!" {
            return true
        } else {
            self.textFieldState = .wrongPassword
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
    case unavailableNickname = "사용할 수 없는 닉네임입니다."
    case differentPassword = "비밀번호가 일치하지 않습니다."
}
