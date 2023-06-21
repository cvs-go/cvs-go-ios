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
                    updatedParameters["images"] = success.data
                    
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
                case .failure:
                    self.showAlertMessage = true
                }
                self.isLoading = false
            }
            .store(in: &bag)
    }
}
