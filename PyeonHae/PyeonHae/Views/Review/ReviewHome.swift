//
//  ReviewHome.swift
//  PyeonHae
//
//  Created by 정건호 on 2023/02/02.
//

import SwiftUI

struct ReviewHome: View {
    @State private var selectedTap: ReviewTapType = .all
    
    var body: some View {
        VStack(spacing: 0) {
            navigationBar
            customTapView()
            Spacer()
        }
    }
    
    @ViewBuilder
    private var navigationBar: some View {
        VStack {
            HStack {
                Spacer().frame(width: 20)
                Text("리뷰")
                    .font(.pretendard(.bold, 20))
                    .foregroundColor(.grayscale100)
                Spacer()
                Image(name: .notification)
                Spacer().frame(width: 16)
                Image(name: .addSquare)
                Spacer().frame(width: 18)
            }
        }
        .frame(height: 44)
    }
    
    @ViewBuilder
    private func customTapView() -> some View {
        VStack(spacing: 0) {
            HStack {
                ForEach(ReviewTapType.allCases, id: \.self) { item in
                    VStack(spacing: 4) {
                        Text(item.rawValue)
                            .font(.pretendard(.semiBold, 16))
                            .frame(maxWidth: .infinity, minHeight: 28)
                            .foregroundColor(selectedTap == item ? .grayscale100 : .grayscale100.opacity(0.3))
                        
                        Rectangle()
                            .foregroundColor(selectedTap == item ? .red100 : .grayscale30)
                            .frame(width: 82, height: selectedTap == item ? 2 : 0)
                    }
                    .onTapGesture {
                        self.selectedTap = item
                    }
                }
            }.zIndex(1)
            Color.grayscale30.frame(height: 1)
                .offset(y: -1)
        }
        .frame(height: 44)
    }
    
}

enum ReviewTapType: String, CaseIterable {
    case all = "전체"
    case follow = "팔로우"
}
