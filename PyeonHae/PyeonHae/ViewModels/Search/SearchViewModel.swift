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
    @Published var reviewDatas: ReviewDatas? = nil
    @Published var productTags: [ProductTagsModel]?

    // 검색 목록 파라미터
    @Published var sortBy: String = String()
    @Published var keyword: String = String()
    @Published var convenienceStoreIds: [Int] = []
    @Published var categoryIds: [Int] = []
    @Published var eventTypes: [String] = []
    @Published var lowestPrice: Int = 0
    @Published var highestPrice: Int = UserShared.filterData?.highestPrice ?? 0
    @Published var page: Int = 0
    
    // 리뷰 목록 파라미터
    @Published var reviewSortBy: String = String()
    @Published var tagIds: [Int] = []
    @Published var ratings: [String] = []
    @Published var reviewPage: Int = 0
    
    // 로딩뷰를 위한 변수
    @Published var productDataLoaded = false
    @Published var reviewDataLoaded = false
    @Published var productListDataLoaded = false
    
    @Published var resultListIsLoading = false
    @Published var detailIsLoading = false
    
    // 선택된 필터 값
    @Published var selectedElements: [String] = []
    
    var bag = Set<AnyCancellable>()
    
    init() {
        subscribeDetailLoadState()
        subscribeProductListLoadState()
    }
    
    // 상품 목록 조회
    func searchProducts() {
        self.page = 0
        self.resultListIsLoading = true
        
        let parameters: [String : Any] = [
            "sortBy": sortBy,
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
                    self.productListDataLoaded = true
                case .failure(let error):
                    print(error)
                }
            }.store(in: &bag)
    }
    
    // 상품 목록 다음 페이지 조회
    func searchMoreProducts() {
        let parameters: [String : Any] = [
            "sortBy": sortBy,
            "convenienceStoreIds": convenienceStoreIds.toParameter(),
            "categoryIds": categoryIds.toParameter(),
            "eventTypes": eventTypes.toParameter(),
            "lowestPrice": lowestPrice,
            "highestPrice": highestPrice,
            "keyword": keyword,
            "page": page
        ]
        
        apiManager.request(for: ProductsAPI.search(parameters))
            .sink { (result: Result<ProductModel, Error>) in
                switch result {
                case .success(let result):
                    self.searchResults?.data.content += result.data.content
                    self.searchResults?.data.last = result.data.last
                case .failure(let error):
                    print(error)
                }
            }.store(in: &bag)
    }
    
    // 상품 상세 조회
    func requestProductDetail(productID: Int) {
        detailIsLoading = true
        
        apiManager.request(for: ProductsAPI.product(id: productID))
            .sink { (result: Result<ProductDetail, Error>) in
                switch result {
                case .success(let result):
                    self.productDetail = result
                    self.productDataLoaded = true
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
    
    // 제품 상세 화면 리뷰
    func requestReview(productID: Int) {
        self.reviewPage = 0
        let parameters: [String : Any] = [
            "sortBy": reviewSortBy,
            "tagIds": tagIds.toParameter(),
            "ratings": ratings.toParameter()
        ]
        
        apiManager.request(for: ReviewAPI.productReview(id: productID, parameters: parameters))
            .sink { (result: Result<ProductReviewsModel, Error>) in
                switch result {
                case .success(let result):
                    self.reviewDatas = result.data
                    self.reviewDataLoaded = true
                case .failure(let error):
                    print(error)
                }
            }.store(in: &bag)
    }
    
    // 제품 상세 화면 리뷰 페이징
    func requestMoreReview(productID: Int) {
        let parameters: [String : Any] = [
            "sortBy": reviewSortBy,
            "tagIds": tagIds.toParameter(),
            "ratings": ratings.toParameter(),
            "page": reviewPage
        ]
        
        apiManager.request(for: ReviewAPI.productReview(id: productID, parameters: parameters))
            .sink { (result: Result<ProductReviewsModel, Error>) in
                switch result {
                case .success(let result):
                    self.reviewDatas?.content += result.data.content
                    self.reviewDatas?.last = result.data.last
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
                    self.productTags = result.data
                case .failure(let error):
                    print(error)
                }
            }.store(in: &bag)
    }
    
    func initSearchParameters() {
        selectedElements.removeAll()
        sortBy.removeAll()
        convenienceStoreIds.removeAll()
        categoryIds.removeAll()
        eventTypes.removeAll()
        lowestPrice = 0
        highestPrice = UserShared.filterData?.highestPrice ?? 0
    }
    
    func initReviewParameters() {
        reviewSortBy.removeAll()
        tagIds.removeAll()
        ratings.removeAll()
    }
    
    func subscribeDetailLoadState() {
        Publishers.Zip($productDataLoaded, $reviewDataLoaded)
            .filter { $0.0 && $0.1 }
            .delay(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.detailIsLoading = false
            }
            .store(in: &bag)
    }
    
    func subscribeProductListLoadState() {
        $productListDataLoaded
            .filter { $0 }
            .delay(for: .seconds(0.3), scheduler: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.resultListIsLoading = false
            }
            .store(in: &bag)
    }
}
