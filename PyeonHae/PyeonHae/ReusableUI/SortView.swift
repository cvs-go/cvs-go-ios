//
//  SortView.swift
//  PyeonHae
//
//  Created by 정건호 on 1/13/24.
//

import SwiftUI

struct SortView<Content: View>: View {
    private let type: SortViewType
    private let elementCount: Int
    @Binding var sortBy: String
    @Binding var sortClicked: Bool
    @Binding var keyword: String
    private let content: Content
    private let searchAction: () -> Void
    
    @State private var elementType = String()
    
    init(
        type: SortViewType,
        elementCount: Int,
        sortBy: Binding<String>,
        sortClicked: Binding<Bool>,
        keyword: Binding<String> = .constant(String()),
        @ViewBuilder content: () -> Content,
        searchAction: @escaping () -> Void
    ) {
        self.type = type
        self.elementCount = elementCount
        self._sortBy = sortBy
        self._sortClicked = sortClicked
        self._keyword = keyword
        self.content = content()
        self.searchAction = searchAction
    }
    
    var body: some View {
        Spacer().frame(height: 12)
        ZStack(alignment: .top) {
            HStack(alignment: .top, spacing: 2) {
                Text(elementType)
                    .font(.pretendard(.regular, 12))
                    .foregroundColor(.grayscale85)
                    .padding(.top, 6)
                Text("\(elementCount)개")
                    .font(.pretendard(.bold, 12))
                    .foregroundColor(.grayscale85)
                    .padding(.top, 6)
                Spacer()
                SortSelectView(
                    sortType: type == .review || type == .myInfoReview ? .review : .product,
                    sortBy: $sortBy,
                    sortClicked: $sortClicked
                )
            }
            .padding(.horizontal,20)
            .zIndex(1)
            ScrollView {
                content
            }
            .offset(y: 40)
            .padding(.bottom, 40)
            .refreshable {
                searchAction()
            }
            .onChange(of: sortClicked) { _ in
                searchAction()
            }
        }
        .onAppear {
            if type == .eventProduct {
                elementType = "행사상품 총"
            } else if type == .review {
                elementType = "새로운 리뷰"
            } else if type == .searchResult {
                elementType = "'\(keyword)' 검색 결과"
            } else if type == .myInfoReview {
                elementType = "작성한 리뷰"
            } else if type == .myInfoLike {
                elementType = "좋아요한 제품"
            } else if type == .myInfoBookmark {
                elementType = "북마크한 제품"
            }
        }
    }
}

enum SortViewType {
    case eventProduct
    case review
    case searchResult
    case myInfoReview
    case myInfoLike
    case myInfoBookmark
}
