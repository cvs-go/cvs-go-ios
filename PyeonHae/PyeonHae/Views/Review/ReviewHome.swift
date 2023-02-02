//
//  ReviewHome.swift
//  PyeonHae
//
//  Created by 정건호 on 2023/02/02.
//

import SwiftUI

struct ReviewHome: View {
    @State private var selectedTap: ReviewTapType = .all
    @Namespace private var animation
    
    var body: some View {
        animate()
        Spacer()
    }
    
    @ViewBuilder
    private func animate() -> some View {
        VStack(spacing: 5) {
            HStack {
                ForEach(ReviewTapType.allCases, id: \.self) { item in
                    VStack {
                        Text(item.rawValue)
                            .font(.pretendard(.semiBold, 16))
                            .frame(maxWidth: .infinity/4, minHeight: 28)
                            .foregroundColor(selectedTap == item ? .grayscale100 : .grayscale100.opacity(0.3))
                        
                        if selectedTap == item {
                            Rectangle()
                                .foregroundColor(.red100) // 바꾸기
                                .frame(width: 82, height: 2)
                        }
                    }
                    .onTapGesture {
                        self.selectedTap = item
                    }
                }
            }
            Color.grayscale30.frame(height: 1)
        }
    }
    
}

enum ReviewTapType: String, CaseIterable {
    case all = "전체"
    case follow = "팔로우"
}
