//
//  FilterView.swift
//  PyeonHae
//
//  Created by 정건호 on 2023/02/12.
//

import SwiftUI
import WrappingHStack

struct FilterView: View {
    let filterDatas: [FilterData]
    @Binding private var showFilter: Bool
    @Binding private var selectedElements: [String]
    
    init(
        filterDatas: [FilterData],
        showFilter: Binding<Bool>,
        selectedElements: Binding<[String]>
    ) {
        self.filterDatas = filterDatas
        self._showFilter = showFilter
        self._selectedElements = selectedElements
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
        VStack(spacing: 0) {
            ForEach(Array(filterDatas.enumerated()), id: \.element) { index, data in
                VStack(alignment: .leading) {
                    Text(data.category)
                        .font(.pretendard(.bold, 12))
                        .foregroundColor(.grayscale85)
                    WrappingHStack(data.elements, id: \.self, lineSpacing: 6) { element in
                        SelectableButton(
                            text: element,
                            isSelected: selectedElements.contains(element)
                        )
                        .onTapGesture {
                            if selectedElements.contains(element) {
                                selectedElements.removeAll(where: { $0 == element })
                            } else {
                                selectedElements.append(element)
                            }
                        }
                    }
                }
                .padding(
                    EdgeInsets(
                        top: index == 0 ? 16 : 20,
                        leading: 20,
                        bottom: index == filterDatas.count - 1 ? 16 : 0,
                        trailing: 20
                    )
                )
            }
            .frame(width: UIWindow().screen.bounds.width, alignment: .leading)
        }
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

