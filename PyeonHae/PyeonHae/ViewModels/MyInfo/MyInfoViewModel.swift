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
    @Published var noticeList: [NoticeContentModel] = []
    @Published var noticeDetail: NoticeDetailContent? = nil
    @Published var myReviewData: UserReviewsModel? = nil
    
    var bag = Set<AnyCancellable>()
    
    init() {
        requestMyReviewList()
        requestMyLikeList()
        requestUserInfo()
    }
    
    func requestUserInfo() {
        apiManager.request(for: UserAPI.getUserInfo(userId: UserShared.userId))
            .sink { (result: Result<UserInfoModel, Error>) in
                switch result {
                case .success(let result):
                    self.saveUserInfo(result.data)
                case .failure(let error):
                    print(error)
                }
            }.store(in: &bag)
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
        
        apiManager.request(for: UserAPI.editUserInfo(parameters))
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
                    
                    let editInfoAPI = UserAPI.editUserInfo(parameters)
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
    
    private func requestMyReviewList() {
        let parameters: [String: Any] = [:]
        
        apiManager.request(for: ReviewAPI.userReviews(id: UserShared.userId, parameters: parameters))
            .sink { (result: Result<UserReviewListModel, Error>) in
                switch result {
                case .success(let result):
                    self.myReviewData = result.data
                case .failure(let error):
                    print(error)
                }
            }.store(in: &bag)
    }
    
    func requestMyLikeList() {
        let parameters: [String: Any] = [
            :
        ]
        
        apiManager.request(for: UserAPI.userLikeList(id: UserShared.userId, parameters: parameters))
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
    
    func requestNoticeList() {
        apiManager.request(for: UserAPI.noticeList)
            .sink { (result: Result<NoticeListModel, Error>) in
                switch result {
                case .success(let result):
                    self.noticeList = result.data.content
                case .failure(let error):
                    print(error)
                }
            }.store(in: &bag)
    }
    
    func requestNoticeDetail(id: Int) {
        apiManager.request(for: UserAPI.noticeDetail(id: id))
            .sink { (result: Result<NoticeDetailModel, Error>) in
                switch result {
                case .success(let result):
                    self.noticeDetail = result.data
                case .failure(let error):
                    print(error)
                }
            }.store(in: &bag)
    }
    
    func requestLogout() {
        let parameters: [String: String] = [
            "token": UserShared.refreshToken
        ]
        
        apiManager.request(for: AuthAPI.logout(parameters))
            .sink { (result: Result<EmptyResponse, Error>) in
                switch result {
                case .success(let result):
                    print(result)
                case .failure(let error):
                    print(error)
                }
            }.store(in: &bag)
    }
    
    private func saveUserInfo(_ userInfo: UserInfoDataModel) {
        UserShared.userId = userInfo.id ?? 0
        UserShared.userNickname = userInfo.nickname
        UserShared.userProfileImageUrl = userInfo.profileImageUrl
        UserShared.userTags = userInfo.tags
        UserShared.userReviewLikeCount = userInfo.reviewLikeCount
    }
}
