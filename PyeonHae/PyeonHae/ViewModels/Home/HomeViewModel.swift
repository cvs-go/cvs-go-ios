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
    @Published var isLoading: Bool = true
    @Published var searchAgain: Bool = false // 행사 상품 재검색
    @Published var sortBy: String = String() // 상품 정렬
    
    var eventProductCount = 0
    
    // 행사 상품 조회
    private var eventProductsPublisher: AnyPublisher<Result<ProductModel, Error>, Never> {
        return apiManager.request(for: ProductsAPI.search(["isEvent": true, "sortBy": sortBy]))
    }
    
    var bag = Set<AnyCancellable>()
    
     init() {
         requestHomeViewDatas()
     }
    
    private func requestHomeViewDatas() {
        // 홈 화면 프로모션 요청
        let promotionsPublisher: AnyPublisher<Result<PromotionsModel, Error>, Never>
        = apiManager.request(for: ProductsAPI.promotions)
        //　인기 상품 조회
        let popularProductsPublisher: AnyPublisher<Result<ProductModel, Error>, Never>
        = apiManager.request(for: ProductsAPI.search(["sortBy": "SCORE"]))
        // 인기 리뷰 조회
        let popularReviewsPublisher: AnyPublisher<Result<ReviewListModel, Error>, Never>
        = apiManager.request(for: ReviewAPI.reviewList(parameters: ["sortBy": "LIKE", "size": 10]))
        
        Publishers.Zip4(
            promotionsPublisher,
            eventProductsPublisher,
            popularProductsPublisher,
            popularReviewsPublisher
        )
        .sink { (promotionsResult, eventProductsResult, popularProductsResult, popularReviewsResult) in
            self.isLoading = false
            
            switch promotionsResult {
            case .success(let data):
                self.promotions = data.data.content
            case .failure(let error):
                print(error)
            }

            switch eventProductsResult {
            case .success(let result):
                self.eventProducts = result.data.content
                self.eventProductCount = result.data.totalElements
            case .failure(let error):
                print(error)
            }

            switch popularProductsResult {
            case .success(let result):
                self.popularProducts = result.data.content
            case .failure(let error):
                print(error)
            }

            switch popularReviewsResult {
            case .success(let result):
                self.popularReviews = result.data.reviews
            case .failure(let error):
                print(error)
            }
        }.store(in: &bag)
    }
    
    // 정렬 값에 따른 행사 상품 재요청
    func requestEventProducts() {
        eventProductsPublisher
            .sink { result in
                self.searchAgain = false
                switch result {
                case .success(let result):
                    self.eventProducts = result.data.content
                    self.eventProductCount = result.data.totalElements
                case .failure(let error):
                    print(error)
                }
            }.store(in: &bag)
    }
    
    // 특정 상품 좋아요 태그 조회
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
            .sink { (result: Result<EmptyResponse, Error>) in
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
            .sink { (result: Result<EmptyResponse, Error>) in
                switch result {
                case .success(let result):
                    print(result)
                case .failure(let error):
                    print(error)
                }
            }.store(in: &bag)
    }
    
    // 상품 좋아요
    func requestProductLike(productID: Int) {
        apiManager.request(for: ProductsAPI.like(id: productID))
            .sink { (result: Result<EmptyResponse, Error>) in
                switch result {
                case .success(let result):
                    print(result)
                case .failure(let error):
                    print(error)
                }
            }.store(in: &bag)
    }
    
    // 상품 좋아요 취소
    func requestProductUnlike(productID: Int) {
        apiManager.request(for: ProductsAPI.unlike(id: productID))
            .sink { (result: Result<EmptyResponse, Error>) in
                switch result {
                case .success(let result):
                    print(result)
                case .failure(let error):
                    print(error)
                }
            }.store(in: &bag)
    }
}
