//
//  ReviewHome.swift
//  PyeonHae
//
//  Created by 정건호 on 2023/02/02.
//

import SwiftUI

struct ReviewHome: View {
    @State private var tabItems = ReviewTapType.allCases.map { $0.rawValue }
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
        VStack(spacing: 0) {
            navigationBar
            TopTabBar(
                tabItems: tabItems,
                contents: [
                    AnyView(allReviewTab()),
                    AnyView(followReviewTab())
                ]
            )
        }
        .fullScreenCover(isPresented: $showWriteView) {
            EditReviewView(showWriteView: $showWriteView)
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
                Image(name: .addSquare)
                    .onTapGesture {
                        showWriteView = true
                    }
                Spacer().frame(width: 18)
            }
        }
        .frame(height: 44)
    }
    
    @ViewBuilder
    private func allReviewTab() -> some View {
        ScrollView {
            VStack(spacing: 0) {
                Spacer().frame(height: 10)
                
                // TODO: 리뷰 필터 뷰 수정하기
//                FilterView(
//                    filterDatas: filterDatas,
//                    showFilter: $showFilter,
//                    selectedElements: $selectedElements
//                )
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
    
    private func followReviewTab() -> some View {
        VStack {
            Text("팔로우 탭")
            Spacer()
        }
    }
}
