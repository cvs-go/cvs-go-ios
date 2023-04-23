//
//  SearchViewModel.swift
//  PyeonHae
//
//  Created by 정건호 on 2023/04/16.
//

import Foundation
import Combine

class SearchViewModel: ObservableObject {
    private let apiManager = APIManager()
    
    @Published var filtersData: FiltersDataModel?
    @Published var searchResults: ProductModel?

    // 검색 api parameters
    @Published var keyword: String = String()
    @Published var convenienceStoreIds: [Int] = []
    @Published var categoryIds: [Int] = []
    @Published var eventTypes: [String] = []
    @Published var lowestPrice: Int = 0
    @Published var highestPrice: Int = 0
    
    var bag = Set<AnyCancellable>()
    
    init() {
        requestFilterDatas()
    }
    
    func requestFilterDatas() {
        apiManager.request(for: ProductsAPI.filter)
            .sink { (result: Result<FiltersModel, Error>) in
                switch result {
                case .success(let data):
                    self.filtersData = data.data
                case .failure(let error):
                    print(error)
                }
            }
            .store(in: &bag)
    }
    
    func searchProducts() {
        let parameters: [String : Any] = [
            "keyword": keyword,
            "convenienceStoreIds": convenienceStoreIds,
            "categoryIds": categoryIds,
            "eventTypes": eventTypes,
            "lowestPrice": lowestPrice
        ]
        
        apiManager.request(for: ProductsAPI.search(parameters))
            .sink { (result: Result<ProductModel, Error>) in
                switch result {
                case .success(let result):
                    self.searchResults = result
                case .failure(let error):
                    print(error)
                }
            }.store(in: &bag)
    }
}
