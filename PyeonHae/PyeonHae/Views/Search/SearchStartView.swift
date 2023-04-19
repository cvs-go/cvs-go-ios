//
//  SearchStartView.swift
//  PyeonHae
//
//  Created by 정건호 on 2023/04/19.
//

import SwiftUI

struct SearchStartView: View {
    @Binding var text: String
    
    var body: some View {
        VStack {
            SearchBar(text: $text, searchBarType: .editable)
            Spacer().frame(height: 14)
            
            Group {
                VStack {
                    HStack {
                        Text("최근 찾은 상품")
                            .font(.pretendard(.bold, 14))
                            .foregroundColor(.grayscale100)
                        Spacer()
                    }
                }
                
                // 임시 코드
                Spacer().frame(height: 80)
                
                VStack {
                    HStack {
                        Text("이전 검색어")
                            .font(.pretendard(.bold, 14))
                            .foregroundColor(.grayscale100)
                        Spacer()
                    }
                }
                
                // 임시 코드
                Spacer().frame(height: 80)
                
                VStack {
                    HStack {
                        Text("인기 검색어")
                            .font(.pretendard(.bold, 14))
                            .foregroundColor(.grayscale100)
                        Spacer()
                    }
                }
                Spacer()
            }
            .padding(.horizontal, 20) // 임시 코드
        }
    }
}
