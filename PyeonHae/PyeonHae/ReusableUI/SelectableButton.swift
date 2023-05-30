//
//  SelectableButton.swift
//  PyeonHae
//
//  Created by 정건호 on 2023/02/12.
//

import SwiftUI

struct SelectableButton: View {
    private let text: String
    private var isSelected: Bool
    
    init(
        text: String,
        isSelected: Bool
    ) {
        self.text = text
        self.isSelected = isSelected
    }
    
    var body: some View {
        Text(text)
            .font(.pretendard(.regular, 14))
            .foregroundColor(isSelected ? Color.red100 : Color.grayscale100)
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
