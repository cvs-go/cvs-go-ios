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
    
    var bag = Set<AnyCancellable>()
    
    init() {
        requestPromotions()
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
}
