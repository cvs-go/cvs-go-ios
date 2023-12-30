//
//  SortSelectView.swift
//  PyeonHae
//
//  Created by 이주화 on 2023/06/04.
//

import SwiftUI

struct SortSelectView: View {
    let sortType: SortType
    @State private var isDropdownOpen = false
    @State private var currentSort = String() // 최근에 선택된 정렬 값 ex) 별점순, 랭킹순
    @Binding var sortBy: String // 정렬 파라미터로 쓰이는 값 ex) RATING, SCORE
    @Binding var searchAgain: Bool
    
    private var sortValues: [String] {
        if sortType == .product {
            return ["랭킹순", "별점순", "리뷰순"]
        } else {
            return ["최신순", "별점순", "도움순"]
        }
    }
    
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
                        Text(currentSort)
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
                        ForEach(sortValues, id: \.self) { value in
                            if currentSort != value {
                                Button(action: {
                                    currentSort = value
                                    sortBy = convertToParameter(value)
                                    searchAgain.toggle()
                                    isDropdownOpen.toggle()
                                }) {
                                    HStack(spacing: 6) {
                                        Text(value)
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
        .onAppear {
            self.currentSort = sortType == .product ? "랭킹순" : "최신순"
        }
    }
    
    private func convertToParameter(_ value: String) -> String {
        if value == "최신순" {
            return "LATEST"
        } else if value == "도움순" {
            return "LIKE"
        } else if value == "랭킹순" {
            return "SCORE"
        } else if value == "리뷰순" {
            return "REVIEW_COUNT"
        } else {
            return "RATING"
        }
    }
}

enum SortType {
    case product
    case review
}
