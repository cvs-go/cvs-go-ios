//
//  MyInfoViewModel.swift
//  PyeonHae
//
//  Created by 정건호 on 2023/07/27.
//

import UIKit
import Combine

class MyInfoViewModel: ObservableObject {
    private let apiManager = APIManager()
    
    var bag = Set<AnyCancellable>()
    
    init() {
        requestUserLikeList(id: UserShared.userId)
    }
    
    func requestEditInfo(
        nickname: String,
        tagIds: [Int],
        completion: @escaping () -> Void
    ) {
        let parameters: [String: Any] = [
            "nickname": nickname,
            "tagIds": tagIds
        ]
        
        apiManager.request(for: UserAPI.editInfo(parameters))
            .sink { (result: Result<EmptyResponse, Error>) in
                switch result {
                case .success:
                    completion()
                case .failure(let error):
                    print(error)
                }
            }.store(in: &bag)
    }
    
    func requestEditInfoWithImage(
        nickname: String,
        tagIds: [Int],
        images: [UIImage],
        completion: @escaping () -> Void
    ) {
        let api = ImageAPI(images: images, folder: .profile)
        
        apiManager.upload(api: api)
            .flatMap { (response: Result<ImageResponse, Error>) ->
                AnyPublisher<Result<EmptyResponse, Error>, Never> in
                switch response {
                case .success(let success):
                    let parameters: [String: Any] = [
                        "nickname": nickname,
                        "tagIds": tagIds,
                        "profileImageUrl": success.data.first ?? String()
                    ]
                    
                    let editInfoAPI = UserAPI.editInfo(parameters)
                    return self.apiManager.request(for: editInfoAPI)
                case .failure(let failure):
                    return Just.eraseToAnyPublisher(.init(.failure(failure)))()
                }
            }
            .sink { result in
                switch result {
                case .success:
                    completion()
                case .failure(let error):
                    print(error)
                }
            }.store(in: &bag)
    }
    
    func requestUserLikeList(id: Int) {
        let parameters: [String: Any] = [
            :
        ]
        
        apiManager.request(for: UserAPI.userLikeList(id: id, parameters: parameters))
            .sink { (result: Result<UserLikeList, Error>) in
                switch result {
                case .success(let result):
                    print(result)
                case .failure(let error):
                    print(error)
                }
            }.store(in: &bag)
    }
    
    func requestUserBookmarkList() {
        
    }
}
