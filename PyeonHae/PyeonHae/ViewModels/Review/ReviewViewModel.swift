//
//  ReviewViewModel.swift
//  PyeonHae
//
//  Created by 정건호 on 2023/06/06.
//

import Foundation
import Combine
import UIKit

struct ImageResponse: Codable {
    let timestamp: String
    let data: [String]
}

class ReviewViewModel: ObservableObject {
    private let apiManager = APIManager()
    
    @Published var showWriteView = false
    @Published var showToastMessage = false
    @Published var showAlertMessage = false
    @Published var errorMessage = String()
    @Published var isLoading = false
    
    @Published var latestReviewCount: Int = 0
    @Published var reviewList: [ReviewDataModel] = []
    
    @Published var categoryIds: [Int] = []
    @Published var tagIds: [Int] = []
    @Published var ratings: [String] = []
    
    var bag = Set<AnyCancellable>()
    
    init() {
        subscribeErrorMessage()
    }
    
    private func subscribeErrorMessage() {
        apiManager.errorMessageSubject
            .receive(on: DispatchQueue.main)
            .sink { errorMessage in
                self.errorMessage = errorMessage
            }
            .store(in: &bag)
    }
    
    func writeReview(productID: Int, parameters: [String : Any]) {
        apiManager.request(for: ReviewAPI.writeReview(
            id: productID,
            parameters: parameters
        ))
        .sink { (result: Result<EmptyResponse, Error>) in
            switch result {
            case .success:
                self.showWriteView = false
                self.showToastMessage = true
                self.requestReviewList()
            case .failure:
                self.showAlertMessage = true
            }
            self.isLoading = false
        }
        .store(in: &bag)
    }
    
    func writePhotoReview(productID: Int, parameters: [String: Any], images: [UIImage]) {
        let api = ImageAPI(images: images, folder: .review)
        
        apiManager.upload(api: api)
            .flatMap { (response: Result<ImageResponse, Error>) ->
                AnyPublisher<Result<EmptyResponse, Error>, Never> in
                switch response {
                case .success(let success):
                    var updatedParameters = parameters
                    updatedParameters["imageUrls"] = success.data
                    
                    let writeReviewAPI = ReviewAPI.writeReview(id: productID, parameters: updatedParameters)
                    return self.apiManager.request(for: writeReviewAPI)
                case .failure(let failure):
                    return Just.eraseToAnyPublisher(.init(.failure(failure)))()
                }
            }
            .sink { result in
                switch result {
                case .success:
                    self.showWriteView = false
                    self.showToastMessage = true
                    self.requestReviewList()
                case .failure:
                    self.showAlertMessage = true
                }
                self.isLoading = false
            }
            .store(in: &bag)
    }
    
    func requestReviewList() {
        let parameters: [String : Any] = [
            "sortBy": "LATEST",
            "categoryIds": categoryIds.toParameter(),
            "tagIds": tagIds.toParameter(),
            "ratings": ratings.toParameter()
        ]
        
        apiManager.request(for: ReviewAPI.reviewList(parameters: parameters))
        .sink { (result: Result<ReviewListModel, Error>) in
            switch result {
            case .success(let result):
                self.latestReviewCount = result.data.latestReviewCount
                self.reviewList = result.data.reviews
            case .failure(let error):
                print(error)
            }
            self.isLoading = false
        }
        .store(in: &bag)
    }
    
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
