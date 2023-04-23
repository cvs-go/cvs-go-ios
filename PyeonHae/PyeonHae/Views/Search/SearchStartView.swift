//
//  SearchStartView.swift
//  PyeonHae
//
//  Created by 정건호 on 2023/04/19.
//

import SwiftUI

struct SearchStartView: View {
    @ObservedObject var searchViewModel = SearchViewModel()
    
    @Binding var text: String
    @State private var showResultView = false
    
    var body: some View {
        VStack {
            SearchBar(
                text: $text,
                showResultView: $showResultView,
                searchBarType: .start
            )
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
            
            NavigationLink(
                destination: SearchResultView(
                    searchViewModel: searchViewModel,
                    text: $text
                ).navigationBarHidden(true),
                isActive: $showResultView
            ) {
                EmptyView()
            }
        }
    }
}
