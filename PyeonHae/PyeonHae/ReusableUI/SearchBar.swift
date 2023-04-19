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
    let searchBarType: searchBarType
    @FocusState private var isFocused
    @State private var startSearch = false
    
    var body: some View {
        VStack(spacing: 9) {
            HStack(spacing: 0) {
                if searchBarType == .editable {
                    Image(name: .arrowLeft)
                        .resizable()
                        .frame(width: 24, height: 24)
                        .onTapGesture {
                            self.presentationMode.wrappedValue.dismiss()
                        }
                }
                TextField(
                    String(),
                    text: $text,
                    prompt: Text("찾고싶은 상품을 입력하세요.")
                        .font(.pretendard(.regular, 14))
                        .foregroundColor(.grayscale50)
                )
                .focused($isFocused)
                Image(name: .searchIcon)
                    .resizable()
                    .frame(width: 24, height: 24)
                    .padding(.vertical, 2)
            }
            .padding(EdgeInsets(
                top: 8,
                leading: searchBarType == .editable ? 14 : 20,
                bottom: 0,
                trailing: 18)
            )
        }
        .onAppear {
            if searchBarType == .uneditable {
                self.isFocused = false
                self.text = String()
            } else {
                self.isFocused = true
            }
        }
        .onTapGesture {
            if searchBarType == .uneditable {
                startSearch = true
            }
        }
        .overlay(
            Rectangle()
                .frame(height: 1)
                .foregroundColor(isFocused ? Color.red100 : Color.grayscale30)
                .offset(y: 8)
            , alignment: .bottom
        )
        
        NavigationLink(
            destination: SearchStartView(text: $text).navigationBarHidden(true),
            isActive: $startSearch)
        {
            EmptyView()
        }
        .padding(.bottom, 8)
    }
}

enum searchBarType {
    case editable
    case uneditable
}
