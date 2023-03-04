//
//  TextFieldWithTitle.swift
//  PyeonHae
//
//  Created by 정건호 on 2022/12/25.
//

import SwiftUI

struct TextFieldWithTitle: View {
    @FocusState var isFocused: Bool
    @State var showPassword = false
    @Binding var text: String
    let title: String
    let placeholder: String
    let isSecure: Bool
    let type: TextFieldType
    @Binding var state: TextFieldState
    
    init(
        text: Binding<String>,
        title: String,
        placeholder: String,
        isSecure: Bool,
        type: TextFieldType,
        state: Binding<TextFieldState>
    ) {
        self._text = text
        self.title = title
        self.placeholder = placeholder
        self.isSecure = isSecure
        self.type = type
        self._state = state
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.pretendard(.bold, 14))
                .foregroundColor(.grayscale100)
            Group {
                if isSecure && !showPassword {
                    HStack {
                        SecureField(
                            String(),
                            text: $text,
                            prompt: Text(placeholder)
                                .font(.pretendard(.regular, 14))
                                .foregroundColor(.grayscale50)
                        )
                        Button(action: {
                            self.showPassword.toggle()
                        }) {
                            Image(name: .eyeOn)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                } else if isSecure && showPassword {
                    HStack {
                        TextField(
                            String(),
                            text: $text,
                            prompt: Text(placeholder)
                                .font(.pretendard(.regular, 14))
                                .foregroundColor(.grayscale50)
                        )
                        Button(action: {
                            self.showPassword.toggle()
                        }) {
                            Image(name: .eyeOff)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                else {
                    HStack {
                        TextField(
                            String(),
                            text: $text,
                            prompt: Text(placeholder)
                                .font(.pretendard(.regular, 14))
                                .foregroundColor(.grayscale50)
                        )
                    }
                }
            }
            .focused($isFocused)
            .padding(.horizontal, 10)
            .frame(height: 50)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 1)
                    .foregroundColor(textFieldBorderColor())
                    .opacity(isFocused ? 1 : 0)
            )
            .font(.pretendard(.regular, 18))
            .background(Color.grayscale10)
            .cornerRadius(10)
            
            if state != .normal {
                Text(state.rawValue)
                    .font(.pretendard(.regular, 14))
                    .foregroundColor(textFieldGuideColor())
            }
        }
    }
    
    func textFieldBorderColor() -> Color {
        switch state {
        case .normal:
            return .grayscale30
        case .checkEmail:
            return .systemRed
        case .wrongPassword:
            return .systemRed
        case .checkPassword:
            return .systemRed
        case .availablePassword:
            return .grayscale30
        case .unavailableNickname:
            return .systemRed
        case .differentPassword:
            return .systemRed
        }
    }
    
    func textFieldGuideColor() -> Color {
        switch state {
        case .normal:
            return .white
        case .checkEmail:
            return .systemRed
        case .wrongPassword:
            return .systemRed
        case .checkPassword:
            return .systemRed
        case .availablePassword:
            return .systemGreen
        case .unavailableNickname:
            return .systemRed
        case .differentPassword:
            return .systemRed
        }
    }
}

enum TextFieldType {
    case email
    case loginPassword
    case signupPassword
    case signupCheckPassword
    case nickname
}
