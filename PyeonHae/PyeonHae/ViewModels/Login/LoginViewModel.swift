//
//  LoginViewModel.swift
//  PyeonHae
//
//  Created by 정건호 on 2023/01/02.
//

import Foundation
import Combine
import Alamofire

class LoginViewModel: ObservableObject {
    private let apiManager = APIManager()
    
    @Published var textFieldState: TextFieldState = .normal
    @Published var textFieldType: TextFieldType = .email
    @Published var email: String = String()
    @Published var password: String = String()
    @Published var checkPassword: String = String()
    @Published var nickname: String = String()
    
    // Tags
    @Published var tags: [TagModel] = []
    @Published var selectedTags: [TagModel] = []
    
    // Check Email
    @Published var pushToLogin: Bool = false
    @Published var pushToSignUp: Bool = false
    
    // Check Nickname
    @Published var checkNicknameValue: Bool = false
    
    // Success SignUp
    @Published var pushToSuccess: Bool = false
    
    var bag = Set<AnyCancellable>()
    
    init() {
        subscribeTextFields()
    }
    
    private func subscribeTextFields() {
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
    
    // 이메일 중복 검사 api
    func checkEmail() {
        apiManager.request(api: LoginAPI.checkEmail(email: email))
            .sink { (result: Result<CheckEmailModel, Error>) in
                switch result {
                case .success(let data):
                    if data.data {
                        self.pushToLogin = true
                    } else {
                        self.pushToSignUp = true
                    }
                case .failure(let error):
                    print(error)
                }
            }.store(in: &bag)
    }
    
    // 닉네임 중복 검사 api
    func checkNickname() {
        apiManager.request(api: LoginAPI.checkNickname(nickname: nickname))
            .sink { (result: Result<CheckNicknameModel, Error>) in
                switch result {
                case .success(let data):
                    if data.data {
                        self.textFieldState = .unavailableNickname
                        self.checkNicknameValue = false
                    } else {
                        self.checkNicknameValue = true
                    }
                case .failure(let error):
                    print(error)
                }
            }.store(in: &bag)
    }
    
    // 로그인 api
    func tryToLogin() {
        let parameters: [String : String] = [
            "email" : email,
            "password" : password
        ]
        apiManager.request(api: LoginAPI.login(parameters))
            .sink { (result: Result<LoginModel, Error>) in
                switch result {
                case .success(let data):
                    print(data)
                case .failure:
                    self.textFieldState = .wrongPassword
                }
            }.store(in: &bag)
    }
    
    // 태그 api
    func getTags() {
        apiManager.request(api: LoginAPI.getTags)
            .sink { (result: Result<TagsModel, Error>) in
                switch result {
                case .success(let data):
                    self.tags = data.data
                case .failure(let error):
                    print(error)
                }
            }.store(in: &bag)
    }
    
    // 회원가입 api
    func requestSignUp() {
        let parameters: [String : Any] = [
            "email" : email,
            "password" : password,
            "nickname" : nickname,
            "tagIds" : selectedTags.map { $0.id }
        ]
        apiManager.request(api: LoginAPI.signUp(parameters))
            .sink { (result: Result<SignUpModel, Error>) in
                switch result {
                case .success:
                    self.pushToSuccess = true
                case .failure(let error):
                    print(error)
                }
            }.store(in: &bag)
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
