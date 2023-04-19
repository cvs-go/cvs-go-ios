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
}
