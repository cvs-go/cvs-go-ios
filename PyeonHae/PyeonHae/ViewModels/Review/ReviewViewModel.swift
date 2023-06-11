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
    
    func writeReview(productID: Int, parameters: [String : Any], images: [UIImage]) {
            let api = ImageAPI(images: images, folder: "review")

            apiManager.request(for: api)
                .sink { (result: Result<ImageResponse, Error>) in
                    switch result {
                    case .success(let response):
                        var updatedParameters = parameters
                        updatedParameters["images"] = response.data

                        self.apiManager.request(for: ReviewAPI.writeReview(
                            id: productID,
                            parameters: updatedParameters
                        ))
                        .sink { (result: Result<EmptyResponse, Error>) in
                            switch result {
                            case .success:
                                self.showWriteView = false
                                self.showToastMessage = true
                            case .failure:
                                self.showAlertMessage = true
                            }
                        }
                        .store(in: &self.bag)
                    case .failure:
                        self.showAlertMessage = true
                    }
                }
                .store(in: &bag)
        }
}
