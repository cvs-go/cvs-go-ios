//
//  EditLetter.swift
//  PyeonHae
//
//  Created by 이주화 on 2023/02/09.
//

import SwiftUI

struct EditLetterView: View {
    @FocusState private var isFocused
    @Binding var content: String
    private let textPlaceholder: String = "리뷰를 5개 이상 등록하면 정회원으로 승급됩니다.\n정회원이 되시면 모든 리뷰를 감상하실 수 있습니다."
    
    var body: some View {
        VStack {
            ZStack(alignment: .topLeading) {
                TextEditor(text: $content)
                    .font(.pretendard(.regular, 16))
                    .foregroundColor(.grayscale85)
                    .padding(.horizontal, 15)
                    .padding(.vertical, 20)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                    .focused($isFocused)
                if content.isEmpty {
                    Text(textPlaceholder)
                        .font(.pretendard(.regular, 14))
                        .lineSpacing(5)
                        .foregroundColor(.grayscale50)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 28)
                        .onTapGesture {
                            isFocused = true
                        }
                }
            }
            Divider()
        }
        .background(Color.white)
    }
}
