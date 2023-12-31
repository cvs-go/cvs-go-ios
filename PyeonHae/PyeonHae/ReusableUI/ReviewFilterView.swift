//
//  ReviewFilterView.swift
//  PyeonHae
//
//  Created by 정건호 on 2023/07/08.
//

import SwiftUI
import WrappingHStack

struct ReviewFilterView: View {
    @State private var selectedElements: [String] = []
    @Binding private var showFilter: Bool
    @Binding private var filterClicked: Bool
    @Binding private var categoryIds: [Int]
    @Binding private var tagIds: [Int]
    @Binding private var ratings: [String]
    
    init(
        showFilter: Binding<Bool>,
        filterClicked: Binding<Bool>,
        categoryIds: Binding<[Int]>,
        tagIds: Binding<[Int]>,
        ratings: Binding<[String]>
    ) {
        self._showFilter = showFilter
        self._filterClicked = filterClicked
        self._categoryIds = categoryIds
        self._tagIds = tagIds
        self._ratings = ratings
    }
    
    var body: some View {
        filterButton()
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
            ForEach(Array(selectedElements.enumerated()), id: \.element) { index, element in
                if index < 3 {
                    if index != 0 {
                        Image(name: .grayCircle)
                            .padding(.horizontal, 8)
                    }
                    Text(element)
                        .font(.pretendard(.bold, 12))
                        .foregroundColor(.grayscale85)
                }
            }
            if selectedElements.count > 3 {
                Text("외\(selectedElements.count - 3)")
                    .font(.pretendard(.regular, 12))
                    .foregroundColor(.grayscale85)
                    .padding(.leading, 8)
            }
            Spacer().frame(width: 20)
        }
        .frame(height: 32)
        .onTapGesture {
            showFilter.toggle()
        }
        if showFilter {
            filterElements()
                .background(Color.grayscale10)
        }
    }
    
    private func filterElements() -> some View {
        VStack {
            VStack(alignment: .leading) {
                Text("제품")
                    .font(.pretendard(.bold, 12))
                    .foregroundColor(.grayscale85)
                WrappingHStack(UserShared.filterData?.categories ?? [], id: \.self, lineSpacing: 6) { element in
                    SelectableButton(
                        text: element.name,
                        isSelected: selectedElements.contains(element.name)
                    )
                    .onTapGesture {
                        if selectedElements.contains(element.name) {
                            selectedElements.removeAll(where: { $0 == element.name })
                            categoryIds.removeAll(where: { $0 == element.id })
                        } else {
                            selectedElements.append(element.name)
                            categoryIds.append(element.id)
                        }
                        filterClicked.toggle()
                    }
                }
            }
            .padding(.top, 16)
            .padding(.horizontal, 20)
            
            VStack(alignment: .leading) {
                Text("유저")
                    .font(.pretendard(.bold, 12))
                    .foregroundColor(.grayscale85)
                WrappingHStack(UserShared.tags, id: \.self, lineSpacing: 6) { element in
                    SelectableButton(
                        text: element.name,
                        isSelected: selectedElements.contains(element.name)
                    )
                    .onTapGesture {
                        if selectedElements.contains(element.name) {
                            selectedElements.removeAll(where: { $0 == element.name })
                            tagIds.removeAll(where: { $0 == element.id })
                        } else {
                            selectedElements.append(element.name)
                            tagIds.append(element.id)
                        }
                        filterClicked.toggle()
                    }
                }
            }
            .padding(.top, 20)
            .padding(.horizontal, 20)
            
            VStack(alignment: .leading) {
                Text("평점")
                    .font(.pretendard(.bold, 12))
                    .foregroundColor(.grayscale85)
                WrappingHStack(ReviewRating.allCases, id: \.self, lineSpacing: 6) { element in
                    SelectableButton(
                        text: element.rawValue,
                        isSelected: selectedElements.contains(element.rawValue),
                        image: .star
                    )
                    .onTapGesture {
                        if selectedElements.contains(element.rawValue) {
                            selectedElements.removeAll(where: { $0 == element.rawValue })
                            ratings.removeAll(where: { $0 == element.value() })
                        } else {
                            selectedElements.append(element.rawValue)
                            ratings.append(element.value())
                        }
                        filterClicked.toggle()
                    }
                }
            }
            .padding(.vertical, 20)
            .padding(.horizontal, 20)
        }
    }
}

enum ReviewRating: String, CaseIterable {
    case five = "5.0"
    case four = "4.0"
    case three = "3.0"
    case two = "2.0"
    case one = "1.0"
    
    func value() -> String {
        switch self {
        case .five:
            return "5"
        case .four:
            return "4"
        case .three:
            return "3"
        case .two:
            return "2"
        case .one:
            return "1"
        }
    }
}
