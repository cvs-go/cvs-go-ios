//
//  SearchFilterView.swift
//  PyeonHae
//
//  Created by 정건호 on 2023/02/12.
//

import SwiftUI
import WrappingHStack

struct SearchFilterView: View {
    let filterDatas: FiltersDataModel
    @State private var selectedElements: [String] = []
    @Binding private var showFilter: Bool
    @Binding private var convenienceStoreIds: [Int]
    @Binding private var categoryIds: [Int]
    @Binding private var eventTypes: [String]
    @Binding private var filterClicked: Bool
    @Binding private var minPrice: CGFloat
    @Binding private var maxPrice: CGFloat
    
    init(
        filterDatas: FiltersDataModel,
        showFilter: Binding<Bool>,
        convenienceStoreIds: Binding<[Int]>,
        categoryIds: Binding<[Int]>,
        eventTypes: Binding<[String]>,
        filterClicked: Binding<Bool>,
        minPrice: Binding<CGFloat>,
        maxPrice: Binding<CGFloat>
    ) {
        self.filterDatas = filterDatas
        self._showFilter = showFilter
        self._convenienceStoreIds = convenienceStoreIds
        self._categoryIds = categoryIds
        self._eventTypes = eventTypes
        self._filterClicked = filterClicked
        self._minPrice = minPrice
        self._maxPrice = maxPrice
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
                            convenienceStoreIds.removeAll(where: { $0 == element.id })
                        } else {
                            selectedElements.append(element.name)
                            convenienceStoreIds.append(element.id)
                        }
                        filterClicked.toggle()
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
                            categoryIds.removeAll(where: { $0 == element.id })
                        } else {
                            selectedElements.append(element.name)
                            categoryIds.append(element.id)
                        }
                        filterClicked.toggle()
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
                            eventTypes.removeAll(where: { $0 == element.value })
                        } else {
                            selectedElements.append(element.name)
                            eventTypes.append(element.value)
                        }
                        filterClicked.toggle()
                    }
                }
            }
            .padding(.top, 20)
            .padding(.horizontal, 20)
            
            PriceScrollButton(minPrice: $minPrice, maxPrice: $maxPrice, highestPrice: filterDatas.highestPrice)
                .frame(height: 82)
                .padding(.horizontal, 20)
                .padding(.top, 20)
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

