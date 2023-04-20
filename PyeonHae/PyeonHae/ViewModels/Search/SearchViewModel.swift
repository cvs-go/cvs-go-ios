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
    
    var bag = Set<AnyCancellable>()
    
    init() {
        requestFilterDatas()
        searchProducts()
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
            "convenienceStoreIds" : [1],
            "categoryIds" : [1],
            "eventTypes" : ["BOGO"],
            "lowestPrice" : 0,
            "highestPrice" : 1000
        ]
        
        apiManager.request(for: ProductsAPI.search(parameters))
            .sink { (result: Result<ProductModel, Error>) in
                switch result {
                case .success(let products):
                    print(products)
                case .failure(let error):
                    print(error)
                }
            }.store(in: &bag)
    }
}
