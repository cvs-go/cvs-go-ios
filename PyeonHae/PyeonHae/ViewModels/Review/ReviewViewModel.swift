//
//  ReviewViewModel.swift
//  PyeonHae
//
//  Created by 정건호 on 2023/06/06.
//

import Foundation
import Combine

class ReviewViewModel: ObservableObject {
    private let apiManager = APIManager()
    
    var bag = Set<AnyCancellable>()
    
    func writeReview(productID: Int, parameters: [String : Any]) {
        apiManager.request(for: ReviewAPI.writeReview(
            id: productID,
            parameters: parameters
        ))
        .sink { (result: Result<EmptyResponse, Error>) in
            switch result {
            case .success(let data):
                print(data)
            case .failure(let error):
                print(error)
            }
        }
        .store(in: &bag)
    }
}