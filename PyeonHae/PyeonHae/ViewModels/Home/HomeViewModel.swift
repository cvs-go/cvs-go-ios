//
//  HomeViewModel.swift
//  PyeonHae
//
//  Created by 정건호 on 12/4/23.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    private let apiManager = APIManager()
    @Published var promotions: [PromotionContent] = []
    @Published var eventProducts: [Product] = []
    @Published var popularProducts: [Product] = []
    
    var bag = Set<AnyCancellable>()
    
    init() {
        requestPromotions()
        requestEventProducts()
        requestPopularProducts()
    }
    
    // 홈 화면 프로모션 요청
    private func requestPromotions() {
        apiManager.request(for: ProductsAPI.promotions)
            .sink { (result: Result<PromotionsModel, Error>) in
                switch result {
                case .success(let data):
                    self.promotions = data.data.content
                case .failure(let error):
                    print(error)
                }
            }
            .store(in: &bag)
    }
    
    // 행사 상품 조회
    private func requestEventProducts() {
        let parameters: [String : Any] = [
            "isEvent": true
        ]
        
        apiManager.request(for: ProductsAPI.search(parameters))
            .sink { (result: Result<ProductModel, Error>) in
                switch result {
                case .success(let result):
                    self.eventProducts = result.data.content
                case .failure(let error):
                    print(error)
                }
            }.store(in: &bag)
    }
    
    //　인기 상품 조회
    private func requestPopularProducts() {
        let parameters: [String : Any] = [
            "sortBy": "SCORE",
            "size": "3"
        ]
        
        apiManager.request(for: ProductsAPI.search(parameters))
            .sink { (result: Result<ProductModel, Error>) in
                switch result {
                case .success(let result):
                    self.popularProducts = result.data.content
                case .failure(let error):
                    print(error)
                }
            }.store(in: &bag)
    }
}
