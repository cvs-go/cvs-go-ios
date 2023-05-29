//
//  FilterView.swift
//  PyeonHae
//
//  Created by 정건호 on 2023/02/12.
//

import SwiftUI
import WrappingHStack

struct FilterView: View {
    let filterDatas: FiltersDataModel
    @Binding private var showFilter: Bool
    @Binding private var selectedElements: [String]
    
    init(
        filterDatas: FiltersDataModel,
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
        VStack {
            VStack(alignment: .leading) {
                Text("편의점")
                    .font(.pretendard(.bold, 12))
                    .foregroundColor(.grayscale85)
                WrappingHStack(filterDatas.convenienceStores, id: \.self, lineSpacing: 6) { element in
                    SelectableButton(
                        text: element.name,
                        isSelected: selectedElements.contains(element.name)
                    )
                    .onTapGesture {
                        if selectedElements.contains(element.name) {
                            selectedElements.removeAll(where: { $0 == element.name })
                        } else {
                            selectedElements.append(element.name)
                        }
                    }
                }
            }
            .padding(.top, 16)
            .padding(.horizontal, 20)
            
            VStack(alignment: .leading) {
                Text("제품")
                    .font(.pretendard(.bold, 12))
                    .foregroundColor(.grayscale85)
                WrappingHStack(filterDatas.categories, id: \.self, lineSpacing: 6) { element in
                    SelectableButton(
                        text: element.name,
                        isSelected: selectedElements.contains(element.name)
                    )
                    .onTapGesture {
                        if selectedElements.contains(element.name) {
                            selectedElements.removeAll(where: { $0 == element.name })
                        } else {
                            selectedElements.append(element.name)
                        }
                    }
                }
            }
            .padding(.top, 20)
            .padding(.horizontal, 20)
            
            VStack(alignment: .leading) {
                Text("이벤트")
                    .font(.pretendard(.bold, 12))
                    .foregroundColor(.grayscale85)
                WrappingHStack(filterDatas.eventTypes, id: \.self, lineSpacing: 6) { element in
                    SelectableButton(
                        text: element.name,
                        isSelected: selectedElements.contains(element.name)
                    )
                    .onTapGesture {
                        if selectedElements.contains(element.name) {
                            selectedElements.removeAll(where: { $0 == element.name })
                        } else {
                            selectedElements.append(element.name)
                        }
                    }
                }
            }
            .padding(.top, 20)
            .padding(.horizontal, 20)
            
            PriceScrollButton()
                .padding(.horizontal, 20)
                .padding(.top, 20)
                .frame(height: 82)
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

