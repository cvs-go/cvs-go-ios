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
    @Published var productTags: [Int: String] = [:]
    @Published var popularReviews: [ReviewDataModel] = []
    
    var bag = Set<AnyCancellable>()
    
    init() {
        requestPromotions()
        requestEventProducts()
        requestPopularProducts()
        requestPopularReviews()
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
        let parameters: [String: Any] = [
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
    
    func requestProductTag(productId: Int) {
        apiManager.request(for: ProductsAPI.tags(id: productId))
            .sink { (result: Result<ProductTags, Error>) in
                switch result {
                case .success(let result):
                    self.productTags.updateValue(result.data.first?.name ?? String(), forKey: productId)
                case .failure(let error):
                    print(error)
                }
            }.store(in: &bag)
    }
    
    // 인기 리뷰 조회
    private func requestPopularReviews() {
        let parameters: [String: Any] = [
            "sortBy": "LIKE",
            "size": 10
        ]
        
        apiManager.request(for: ReviewAPI.reviewList(parameters: parameters))
            .sink { (result: Result<ReviewListModel, Error>) in
                switch result {
                case .success(let result):
                    self.popularReviews = result.data.reviews
                case .failure(let error):
                    print(error)
                }
            }.store(in: &bag)
    }
    
    // 리뷰 좋아요
    func requestLikeReview(id: Int) {
        apiManager.request(for: ReviewAPI.like(id: id))
        .sink { (result: Result<EmptyResponse, Error>) in
            switch result {
            case .success(let result):
                print(result)
            case .failure(let error):
                print(error)
            }
        }
        .store(in: &bag)
    }
    
    // 리뷰 좋아요 취소
    func requestUnlikeReview(id: Int) {
        apiManager.request(for: ReviewAPI.unlike(id: id))
        .sink { (result: Result<EmptyResponse, Error>) in
            switch result {
            case .success(let result):
                print(result)
            case .failure(let error):
                print(error)
            }
        }
        .store(in: &bag)
    }
    
    // 상품 북마크 생성
    func requestProductBookmark(productID: Int) {
        apiManager.request(for: ProductsAPI.bookmark(id: productID))
            .sink { (result: Result<ProductBookmarkModel, Error>) in
                switch result {
                case .success(let result):
                    print(result)
                case .failure(let error):
                    print(error)
                }
            }.store(in: &bag)
    }
    
    // 상품 북마크 삭제
    func requestProductUnBookmark(productID: Int) {
        apiManager.request(for: ProductsAPI.unbookmark(id: productID))
            .sink { (result: Result<ProductUnBookmarkModel, Error>) in
                switch result {
                case .success(let result):
                    print(result)
                case .failure(let error):
                    print(error)
                }
            }.store(in: &bag)
    }
}
