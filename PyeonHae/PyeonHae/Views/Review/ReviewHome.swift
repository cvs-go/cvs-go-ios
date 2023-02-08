//
//  ReviewHome.swift
//  PyeonHae
//
//  Created by 정건호 on 2023/02/02.
//

import SwiftUI

struct ReviewHome: View {
    @State private var selectedTap: ReviewTapType = .all
    @State private var showFilter = false
    
    // 임시 데이터
    let filterDatas: [FilterData] = [
        FilterData(category: "편의점", elements: ["CU", "GS25", "7일레븐", "Emart24", "미니스톱"]),
        FilterData(category: "제품", elements: ["간편식사", "즉석요리", "과자&빵", "아이스크림", "신선식품", "유제품", "음료", "기타"]),
        FilterData(category: "유저", elements: ["맵부심", "맵찔이", "초코러버", "비건", "다이어터", "대식가", "소식가", "기타"]),
        FilterData(category: "이벤트", elements: ["1+1", "2+1", "3+1", "증정"]),
        
                   ]
    
    var body: some View {
        VStack(spacing: 0) {
            navigationBar
            customTapView()
            Spacer().frame(height: 20)
            filterButton()
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
    
    @ViewBuilder
    private func filterButton() -> some View {
        HStack(spacing: 4) {
            Spacer().frame(width: 20)
            Text("필터")
                .font(.pretendard(.bold, 14))
                .foregroundColor(.grayscale100)
            Image(name: showFilter ? .arrowUp : .arrowDown)
            Spacer()
        }
        .onTapGesture {
            showFilter.toggle()
        }
        .padding(.vertical, 7)
        if showFilter {
            filterView()
                .background(Color.grayscale10)
        }
    }
    
    private func filterView() -> some View {
        ForEach(filterDatas, id: \.self) { data in
            VStack(alignment: .leading) {
                Text(data.category)
                    .font(.pretendard(.bold, 12))
                    .foregroundColor(.grayscale85)
                HStack {
                    ForEach(data.elements, id: \.self) { element in
                        customButton(element)
                    }
                }
            }
            .frame(width: UIWindow().screen.bounds.width)
        }
    }
    
    private func customButton(_ text: String) -> some View {
        Text(text)
            .font(.pretendard(.regular, 14))
            .foregroundColor(.grayscale100)
            .padding(EdgeInsets(top: 7.5, leading: 10, bottom: 7.5, trailing: 10))
            .overlay(
                RoundedRectangle(cornerRadius: 100)
                    .stroke(Color.grayscale30, lineWidth: 1)
            )
    }
}

struct FilterData: Hashable {
    let category: String
    let elements: [String]
    
    init(category: String, elements: [String]) {
        self.category = category
        self.elements = elements
    }
}


enum ReviewTapType: String, CaseIterable {
    case all = "전체"
    case follow = "팔로우"
}
