//
//  SecureFieldWithTitle.swift
//  PyeonHae
//
//  Created by 정건호 on 2022/12/25.
//

import SwiftUI

struct SecureFieldWithTitle: View {
    @State var text = String()
    @FocusState var isFocused: Bool
    let title: String
    let placeholder: String
    
    init(title: String, placeholder: String) {
        self.title = title
        self.placeholder = placeholder
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.pretendard(.bold, 14))
                .foregroundColor(.grayscale100)
            SecureField(
                "",
                text: $text,
                prompt: Text(placeholder)
                    .font(.pretendard(.regular, 14))
                    .foregroundColor(.grayscale50)
            )
            .focused($isFocused)
            .padding(.horizontal, 10)
            .frame(height: 50)
            .overlay(
                   RoundedRectangle(cornerRadius: 10)
                       .stroke(lineWidth: 1)
                       .foregroundColor(.grayscale30)
                       .opacity(isFocused ? 1 : 0)
               )
            .font(.pretendard(.regular, 14))
            .background(Color.grayscale10)
            .cornerRadius(10)
        }
    }
}
