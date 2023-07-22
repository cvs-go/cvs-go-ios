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
    
    // api 통신으로 받아온 데이터
    @Published var searchResults: ProductModel?
    @Published var productDetail: ProductDetail?
    @Published var reviewDatas: ReviewDatas?

    // 검색 api parameters
    @Published var keyword: String = String()
    @Published var convenienceStoreIds: [Int] = []
    @Published var categoryIds: [Int] = []
    @Published var eventTypes: [String] = []
    @Published var lowestPrice: Int = 0
    @Published var highestPrice: Int = UserShared.filterData?.highestPrice ?? 0
    
    // detail 화면으로 이동
    @Published var showProductDetail = false
    
    @Published var isLoading = false
    
    var bag = Set<AnyCancellable>()
    
    // 상품 목록 조회
    func searchProducts() {
        let parameters: [String : Any] = [
            "convenienceStoreIds": convenienceStoreIds.toParameter(),
            "categoryIds": categoryIds.toParameter(),
            "eventTypes": eventTypes.toParameter(),
            "lowestPrice": lowestPrice,
            "highestPrice": highestPrice,
            "keyword": keyword
        ]
        
        apiManager.request(for: ProductsAPI.search(parameters))
            .sink { (result: Result<ProductModel, Error>) in
                switch result {
                case .success(let result):
                    self.searchResults = result
                case .failure(let error):
                    print(error)
                }
                self.isLoading = false
            }.store(in: &bag)
    }
    
    // 상품 상세 조회
    func requestProductDetail(productID: Int) {
        apiManager.request(for: ProductsAPI.product(id: productID))
            .sink { (result: Result<ProductDetail, Error>) in
                switch result {
                case .success(let result):
                    self.productDetail = result
                    self.showProductDetail = true
                case .failure(let error):
                    print(error)
                }
            }.store(in: &bag)
    }
    
    // 상품 좋아요 생성
    func requestProductLike(productID: Int) {
        apiManager.request(for: ProductsAPI.like(id: productID))
            .sink { (result: Result<ProductLikeModel, Error>) in
                switch result {
                case .success(let result):
                    print(result)
                case .failure(let error):
                    print(error)
                }
            }.store(in: &bag)
    }
    
    // 상품 좋아요 삭제
    func requestProductUnLike(productID: Int) {
        apiManager.request(for: ProductsAPI.unlike(id: productID))
            .sink { (result: Result<ProductUnLikeModel, Error>) in
                switch result {
                case .success(let result):
                    print(result)
                case .failure(let error):
                    print(error)
                }
            }.store(in: &bag)
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
    
    func productLike(productID: Int, _ isLike: Bool) {
        if isLike {
            requestProductLike(productID: productID)
        } else {
            requestProductUnLike(productID: productID)
        }
    }
    
    func productBookmark(productID: Int, _ isBookmark: Bool) {
        if isBookmark {
            requestProductBookmark(productID: productID)
        } else {
            requestProductUnBookmark(productID: productID)
        }
    }
    
    func requestReview(productID: Int) {
        let parameters: [String : Any] = [
            :
        ]
        
        apiManager.request(for: ReviewAPI.productReview(id: productID, parameters: parameters))
            .sink { (result: Result<ProductReviewsModel, Error>) in
                switch result {
                case .success(let result):
                    self.reviewDatas = result.data
                case .failure(let error):
                    print(error)
                }
            }.store(in: &bag)
    }
    
    func initFilters() {
        convenienceStoreIds.removeAll()
        categoryIds.removeAll()
        eventTypes.removeAll()
        lowestPrice = 0
        highestPrice = UserShared.filterData?.highestPrice ?? 0
    }
}
