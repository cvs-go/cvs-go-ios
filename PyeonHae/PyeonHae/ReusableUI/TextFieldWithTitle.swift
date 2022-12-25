//
//  TextFieldWithTitle.swift
//  PyeonHae
//
//  Created by 정건호 on 2022/12/25.
//

import SwiftUI

struct TextFieldWithTitle: View {
    @State var text = String()
    @FocusState var isFocused: Bool
    @State var showPassword = false
    let title: String
    let placeholder: String
    let isSecure: Bool
    
    init(title: String, placeholder: String, isSecure: Bool) {
        self.title = title
        self.placeholder = placeholder
        self.isSecure = isSecure
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
                       .foregroundColor(.grayscale30)
                       .opacity(isFocused ? 1 : 0)
               )
            .font(.pretendard(.regular, 18))
            .background(Color.grayscale10)
            .cornerRadius(10)
        }
    }
}
