//
//  TopTabBar.swift
//  PyeonHae
//
//  Created by 정건호 on 2023/02/11.
//

import SwiftUI

struct TopTabBar: View {
    private let tabItems: [String]
    private let contents: [AnyView]
    private let type: TabBarType
    @State private var selectedTab: Int = 0
    
    init(
        tabItems: [String],
        contents: [AnyView],
        type : TabBarType
    ) {
        self.tabItems = tabItems
        self.contents = contents
        self.type = type
    }
    
    var body: some View {
        customTapView()
        contents[selectedTab]
    }
    
    @ViewBuilder
    private func customTapView() -> some View {
        VStack(spacing: 0) {
            HStack {
                ForEach(Array(tabItems.enumerated()), id: \.element) { index, item in
                    VStack(spacing: type == .review ? 4 : 10) {
                        Text(item)
                            .font(.pretendard(.semiBold, 16))
                            .frame(maxWidth: .infinity, minHeight: 28)
                            .foregroundColor(selectedTab == index ? .grayscale100 : .grayscale100.opacity(0.3))
                            .padding(.top, 10)
                        
                        Rectangle()
                            .foregroundColor(selectedTab == index ? .red100 : .grayscale30)
                            .frame(width: 82, height: selectedTab == index ? 2 : 0)
                    }
                    .onTapGesture {
                        self.selectedTab = index
                    }
                }
            }.zIndex(1)
            Color.grayscale30.frame(height: 1)
                .offset(y: -1)
        }
        .frame(height: type == .review ? 44 : 52)
    }
}

enum TabBarType {
    case review
    case myInfo
}

enum ReviewTapType: String, CaseIterable {
    case all = "전체"
    case follow = "팔로우"
}

enum MyInfoTapType: String, CaseIterable {
    case review = "리뷰"
    case like = "좋아요"
    case bookmark = "북마크"
}
