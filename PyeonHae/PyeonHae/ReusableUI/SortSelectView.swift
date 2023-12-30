//
//  SortSelectView.swift
//  PyeonHae
//
//  Created by 이주화 on 2023/06/04.
//

import SwiftUI

struct SortSelectView: View {
    @State private var isDropdownOpen = false
    @Binding var selectedOptionIndex: Int
    private let options = ["랭킹순", "별점순", "리뷰순"]
    
    var body: some View {
        ZStack {
            if isDropdownOpen {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.grayscale20, lineWidth: 1)
                    .background(Color.white)
                    .frame(width: 64.5, height: 73)
            }
            VStack(spacing: 0) {
                Button(action: {
                    isDropdownOpen.toggle()
                }) {
                    HStack(spacing: 6) {
                        Text(options[selectedOptionIndex])
                            .font(.pretendard(.regular, 12))
                            .foregroundColor(.grayscale85)
                        Image(name: .invertedTriangle)
                    }
                    .frame(width: 64.5, height: 26)
                    .background(Color.grayscale10)
                    .cornerRadius(10)
                }
                if isDropdownOpen {
                    VStack(alignment: .leading, spacing: 0) {
                        ForEach(options.indices, id: \.self) { index in
                            if index != selectedOptionIndex {
                                Button(action: {
                                    selectedOptionIndex = index
                                    isDropdownOpen.toggle()
                                }) {
                                    HStack(spacing: 6) {
                                        Text(options[index])
                                            .font(.pretendard(.regular, 12))
                                            .foregroundColor(.grayscale50)
                                        Spacer()
                                    }
                                    .frame(width: 48.5, height: 23.5)
                                }
                            }
                        }
                    }
                }
            }
            .frame(width: 64.5, height: isDropdownOpen ? 73 : 26)
        }
        
    }
}
