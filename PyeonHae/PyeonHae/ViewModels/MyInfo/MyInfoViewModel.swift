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
    @Published var myLikeData: Products? = nil
    @Published var myBookmarkData: Products? = nil
    
    // 정렬 파라미터
    @Published var reviewSortBy = String()
    @Published var likeSortBy = String()
    @Published var bookmarkSortBy = String()
    
    // 페이징
    @Published var reviewPage = 0
    @Published var likePage = 0
    @Published var bookmarkPage = 0
    @Published var reviewLast = false
    @Published var likeLast = false
    @Published var bookmarkLast = false
    
    var bag = Set<AnyCancellable>()
    
    init() {
        requestMyReviewList()
        requestMyLikeList()
        requestMyBookmarkList()
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
    
    // 내가 쓴 리뷰 조회
    func requestMyReviewList() {
        self.reviewPage = 0
        self.reviewLast = false
        let parameters: [String: Any] = [
            "sortBy": reviewSortBy
        ]
        
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
    
    // 내가 쓴 리뷰 다음 페이지 조회
    func requestMoreMyReviewList() {
        let parameters: [String: Any] = [
            "sortBy": reviewSortBy,
            "page": reviewPage
        ]
        
        apiManager.request(for: ReviewAPI.userReviews(id: UserShared.userId, parameters: parameters))
            .sink { (result: Result<UserReviewListModel, Error>) in
                switch result {
                case .success(let result):
                    self.myReviewData?.content += result.data.content
                    self.reviewLast = result.data.last
                case .failure(let error):
                    print(error)
                }
            }.store(in: &bag)
    }
    
    // 내가 좋아요한 상품 조회
    func requestMyLikeList() {
        self.likePage = 0
        self.likeLast = false
        let parameters: [String: Any] = [
            "sortBy": likeSortBy
        ]
        
        apiManager.request(for: UserAPI.userLikeList(id: UserShared.userId, parameters: parameters))
            .sink { (result: Result<UserLikeList, Error>) in
                switch result {
                case .success(let result):
                    self.myLikeData = result.data
                case .failure(let error):
                    print(error)
                }
            }.store(in: &bag)
    }
    
    // 내가 좋아요한 상품 다음 페이지 조회
    func requestMoreMyLikeList() {
        let parameters: [String: Any] = [
            "sortBy": likeSortBy,
            "page": likePage
        ]
        
        apiManager.request(for: UserAPI.userLikeList(id: UserShared.userId, parameters: parameters))
            .sink { (result: Result<UserLikeList, Error>) in
                switch result {
                case .success(let result):
                    self.myLikeData?.content += result.data.content
                    self.likeLast = result.data.last
                case .failure(let error):
                    print(error)
                }
            }.store(in: &bag)
    }
    
    // 내가 북마크한 상품 조회
    func requestMyBookmarkList() {
        self.bookmarkPage = 0
        self.bookmarkLast = false
        let parameters: [String: Any] = [
            "sortBy": bookmarkSortBy
        ]
        
        apiManager.request(for: UserAPI.userBookmarkList(id: UserShared.userId, parameters: parameters))
            .sink { (result: Result<UserBookmarkList, Error>) in
                switch result {
                case .success(let result):
                    self.myBookmarkData = result.data
                case .failure(let error):
                    print(error)
                }
            }.store(in: &bag)
    }
    
    // 내가 북마크한 상품 다음 페이지 조회
    func requestMoreMyBookmarkList() {
        let parameters: [String: Any] = [
            "sortBy": bookmarkSortBy,
            "page": bookmarkPage
        ]
        
        apiManager.request(for: UserAPI.userBookmarkList(id: UserShared.userId, parameters: parameters))
            .sink { (result: Result<UserBookmarkList, Error>) in
                switch result {
                case .success(let result):
                    self.myBookmarkData?.content += result.data.content
                    self.bookmarkLast = result.data.last
                case .failure(let error):
                    print(error)
                }
            }.store(in: &bag)
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
}
