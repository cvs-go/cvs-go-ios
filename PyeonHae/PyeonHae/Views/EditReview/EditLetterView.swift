//
//  EditLetter.swift
//  PyeonHae
//
//  Created by 이주화 on 2023/02/09.
//

import SwiftUI

struct EditLetterView: View {
    @State private var title: String = ""
    @State var text: String = ""
    let textPlaceholder: String = "리뷰는 100자 이상 부터 등록 가능하며,\n리뷰를 5개 이상 등록하면 정회원으로 승급됩니다.\n정회원이 되시면 모든 리뷰를 감상하실 수 있습니다."
    
    var body: some View {
        VStack {
            TextField("제목을 입력해주세요.", text: $title)
                .font(.pretendard(.medium, 18))
                .foregroundColor(.grayscale100)
                .padding(.horizontal, 20)
                .padding(.top, 12)
            Divider()
            ZStack(alignment: .topLeading) {
                TextEditor(text: $text)
                    .font(.pretendard(.regular, 16))
                    .foregroundColor(.grayscale85)
                    .padding(.horizontal, 15)
                    .padding(.vertical, 8)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                    .background(Color.clear)
                if text.isEmpty {
                    Text(textPlaceholder)
                        .font(.pretendard(.regular, 14))
                        .lineSpacing(5)
                        .foregroundColor(.grayscale50)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 16)
                }
            }
            Divider()
            
        }
        .background(Color.white)
    }
}

struct EditLetterView_Previews: PreviewProvider {
    static var previews: some View {
        EditLetterView()
    }
}
