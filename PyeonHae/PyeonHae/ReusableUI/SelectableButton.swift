//
//  SelectableButton.swift
//  PyeonHae
//
//  Created by 정건호 on 2023/02/12.
//

import SwiftUI

enum ButtonImage {
    case none
    case star
}

struct SelectableButton: View {
    private let text: String
    private var isSelected: Bool
    private let image: ButtonImage
    
    init(
        text: String,
        isSelected: Bool,
        image: ButtonImage = .none
    ) {
        self.text = text
        self.isSelected = isSelected
        self.image = image
    }
    
    var body: some View {
        HStack(spacing: 6) {
            if image == .star {
                Image(name: .emptyStar)
                    .resizable()
                    .colorMultiply(.grayscale70)
                    .frame(width: 12, height: 12)
            }
            Text(text)
                .font(.pretendard(.regular, 14))
                .foregroundColor(isSelected ? Color.red100 : Color.grayscale100)
        }
        .padding(EdgeInsets(top: 7.5, leading: 10, bottom: 7.5, trailing: 10))
        .cornerRadius(100)
        .background(
            RoundedRectangle(cornerRadius: 100)
                .fill(isSelected ? Color.red100.opacity(0.1) : Color.white)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 100)
                .stroke(isSelected ? Color.red100 : Color.grayscale30, lineWidth: 1)
        )
    }
}
