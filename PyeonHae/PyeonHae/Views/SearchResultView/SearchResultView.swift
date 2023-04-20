//
//  SearchResultView.swift
//  PyeonHae
//
//  Created by 이주화 on 2023/02/21.
//

import SwiftUI

struct SearchResultView: View {
    @ObservedObject var searchViewModel: SearchViewModel
    @Binding var text: String
    @State private var selectedElements: [String] = []
    @State private var showFilter = false
    @State private var showWriteView = false
    
    // 임시 데이터
    let filterDatas: [FilterData] = [
        FilterData(category: "편의점", elements: ["CU", "GS25", "7일레븐", "Emart24", "미니스톱"]),
        FilterData(category: "제품", elements: ["간편식사", "즉석요리", "과자&빵", "아이스크림", "신선식품", "유제품", "음료", "기타"]),
        FilterData(category: "유저", elements: ["맵부심", "맵찔이", "초코러버", "비건", "다이어터", "대식가", "소식가", "기타"]),
        FilterData(category: "이벤트", elements: ["1+1", "2+1", "3+1", "증정"]),
    ]
    var body: some View {
        VStack {
            SearchBar(text: $text, searchBarType: .result)
            FilterView(
                filterDatas: searchViewModel.filtersData!,
                showFilter: $showFilter,
                selectedElements: $selectedElements
            )
            HStack {
                Spacer().frame(width: 20)
                Text("'아이스크림' 검색 결과 14개")
                    .font(.pretendard(.regular, 12))
                    .foregroundColor(.grayscale85)
                Spacer()
                HStack(spacing: 6) {
                    Text("최신순")
                        .font(.pretendard(.regular, 12))
                        .foregroundColor(.grayscale85)
                    Image(name: .invertedTriangle)
                }
                .frame(width: 64.5, height: 26)
                .background(Color.grayscale10)
                .cornerRadius(10)
                Spacer().frame(width: 20)
            }
            .padding(.bottom, 10)
            ScrollView {
                ForEach(0..<10) { _ in
                    VStack {
                        SearchResultItemView()
                    }
                    .padding(.vertical, 10)
                }
            }
        }
        .onAppear {
            print(self.searchViewModel.filtersData)
        }
    }
    
    @ViewBuilder
    private func allReviewTab() -> some View {
        ScrollView {
            VStack(spacing: 0) {
                Spacer().frame(height: 10)
                FilterView(
                    filterDatas: searchViewModel.filtersData!,
                    showFilter: $showFilter,
                    selectedElements: $selectedElements
                )
                HStack {
                    Spacer().frame(width: 20)
                    Text("새로운 리뷰 14개")
                        .font(.pretendard(.regular, 12))
                        .foregroundColor(.grayscale85)
                    Spacer()
                    HStack(spacing: 6) {
                        Text("최신순")
                            .font(.pretendard(.regular, 12))
                            .foregroundColor(.grayscale85)
                        Image(name: .invertedTriangle)
                    }
                    .frame(width: 64.5, height: 26)
                    .background(Color.grayscale10)
                    .cornerRadius(10)
                    Spacer().frame(width: 20)
                }
                .frame(height: 40)
            }
            ForEach(0..<10) { _ in
                VStack {
                    ReviewUserInfo(reviewType: .normal)
                    ReviewCell()
                }
                .padding(.horizontal, 19)
                Color.grayscale30.opacity(0.5).frame(height: 1)
                    .padding(.bottom, 16)
            }
        }
    }
}
