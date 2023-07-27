//
//  SplashViewModel.swift
//  PyeonHae
//
//  Created by 정건호 on 2023/07/09.
//

import Foundation
import Combine
import UIKit

class SplashViewModel: ObservableObject {
    private let apiManager = APIManager()
    
    var bag = Set<AnyCancellable>()
    
    init() {
        requestTags()
        requestFilterDatas()
    }
    
    // 태그 api
    func requestTags() {
        apiManager.request(for: UserAPI.getTags)
            .sink { (result: Result<TagsModel, Error>) in
                switch result {
                case .success(let data):
                    UserShared.tags = data.data
                case .failure(let error):
                    print(error)
                }
            }.store(in: &bag)
    }
    
    // 상품 필터 조회
    private func requestFilterDatas() {
        apiManager.request(for: ProductsAPI.filter)
            .sink { (result: Result<FiltersModel, Error>) in
                switch result {
                case .success(let data):
                    UserShared.filterData = data.data
                case .failure(let error):
                    print(error)
                }
            }
            .store(in: &bag)
    }
}
