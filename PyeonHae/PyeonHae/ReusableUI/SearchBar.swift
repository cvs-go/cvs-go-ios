//
//  SearchBar.swift
//  PyeonHae
//
//  Created by 정건호 on 2023/04/19.
//

import SwiftUI
import Foundation

struct SearchBar: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @Binding var text: String
    @Binding var showResultView: Bool
    @Binding var searchAgain: Bool
    let searchBarType: searchBarType
    @FocusState private var isFocused
    
    init(
        text: Binding<String>,
        showResultView: Binding<Bool> = .constant(false),
        searchAgain: Binding<Bool> = .constant(false),
        searchBarType: searchBarType
    ) {
        self._text = text
        self._showResultView = showResultView
        self._searchAgain = searchAgain
        self.searchBarType = searchBarType
    }
    
    var body: some View {
        VStack(spacing: 9) {
            HStack(spacing: 0) {
                if searchBarType != .home {
                    Image(name: .arrowLeft)
                        .resizable()
                        .frame(width: 24, height: 24)
                        .onTapGesture {
                            self.presentationMode.wrappedValue.dismiss()
                        }
                }
                ZStack(alignment: .leading) {
                    if text.isEmpty {
                        Text("찾고싶은 상품을 입력하세요.")
                            .font(.pretendard(.regular, 14))
                            .foregroundColor(.grayscale50)
                    }
                    TextField(
                        String(),
                        text: $text,
                        onCommit: {
                            if searchBarType == .start {
                                showResultView = true
                            } else if searchBarType == .result {
                                searchAgain.toggle()
                            }
                        }
                    ).disabled(searchBarType == .home)
                }
                .focused($isFocused)
                Image(name: .searchIcon)
                    .resizable()
                    .frame(width: 24, height: 24)
                    .padding(.vertical, 2)
                    .onTapGesture {
                        if searchBarType == .start {
                            showResultView = true
                        } else if searchBarType == .result {
                            searchAgain.toggle()
                        }
                    }
            }
            .padding(EdgeInsets(
                top: 8,
                leading: searchBarType != .home ? 14 : 20,
                bottom: 0,
                trailing: 18)
            )
        }
        .onAppear {
            if searchBarType == .home {
                self.isFocused = false
                self.text = String()
            } else if searchBarType == .start {
                self.isFocused = true
            }
        }
        .overlay(
            Rectangle()
                .frame(height: 1)
                .foregroundColor(isFocused ? Color.red100 : Color.grayscale30)
                .offset(y: 8)
            , alignment: .bottom
        )
        .padding(.bottom, 8)
    }
}

enum searchBarType {
    case home
    case start
    case result
}
