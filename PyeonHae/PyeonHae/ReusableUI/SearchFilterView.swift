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
    @Binding var selectedElements: [String]
    @Binding var showFilter: Bool
    @Binding var convenienceStoreIds: [Int]
    @Binding var categoryIds: [Int]
    @Binding var eventTypes: [String]
    @Binding var filterClicked: Bool
    @Binding var minPrice: CGFloat
    @Binding var maxPrice: CGFloat
    
    init(
        filterDatas: FiltersDataModel,
        selectedElements: Binding<[String]>,
        showFilter: Binding<Bool>,
        convenienceStoreIds: Binding<[Int]>,
        categoryIds: Binding<[Int]>,
        eventTypes: Binding<[String]>,
        filterClicked: Binding<Bool>,
        minPrice: Binding<CGFloat>,
        maxPrice: Binding<CGFloat>
    ) {
        self.filterDatas = filterDatas
        self._selectedElements = selectedElements
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
            .onAppear {
                if !categoryIds.isEmpty,
                   let categoryName = filterDatas.categories
                    .filter({ categoryIds.contains($0.id) })
                    .map({ $0.name }).first, !selectedElements.contains(categoryName) {
                    selectedElements.append(categoryName)
                }
            }
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
            ForEach(selectedElements.enumeratedArray(), id: \.element) { index, element in
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

