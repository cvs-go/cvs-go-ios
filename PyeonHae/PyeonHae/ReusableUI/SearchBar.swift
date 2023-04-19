//
//  SearchBar.swift
//  PyeonHae
//
//  Created by 정건호 on 2023/04/19.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    var body: some View {
        VStack(spacing: 8) {
            HStack {
                // 백버튼 없으면 disable 시키기
                TextField(
                    String(),
                    text: $text,
                    prompt: Text("찾고싶은 상품을 입력하세요.")
                        .font(.pretendard(.regular, 14))
                        .foregroundColor(.grayscale50)
                )
                Image(name: .searchIcon)
                    .resizable()
                    .frame(width: 24, height: 24)
                    .padding(.vertical, 2)
            }
            .padding(EdgeInsets(top: 8, leading: 20, bottom: 0, trailing: 18))
            
            Color.grayscale30
                .frame(width: UIWindow().screen.bounds.width, height: 1)
        }
    }
}
