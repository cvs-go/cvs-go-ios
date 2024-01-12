//
//  UserAPI.swift
//  PyeonHae
//
//  Created by 정건호 on 2023/02/27.
//

import Foundation
import Alamofire

enum UserAPI: API {
    case checkEmail(email: String)
    case checkNickname(nickname: String)
    case getTags
    case signUp([String : Any])
    case getUserInfo(userId: Int)
    case editUserInfo([String : Any])
    case follow(userId: Int)
    case unfollow(userId: Int)
    case tagMatch(userId: Int)
    case userLikeList(id: Int, parameters: [String : Any])
    case userBookmarkList(id: Int, parameters: [String : Any])
    case noticeList
    case noticeDetail(id: Int)
}

extension UserAPI {
    
    var method: HTTPMethod {
        switch self {
        case .checkEmail, .checkNickname, .getTags, .getUserInfo, .userLikeList,
                .userBookmarkList, .noticeList, .noticeDetail, .tagMatch:
            return .get
        case .signUp, .follow:
            return .post
        case .editUserInfo:
            return .put
        case .unfollow:
            return .delete
        }
    }
    
    var path: String {
        switch self {
        case .checkEmail(let email):
            return "/users/emails/\(email)/exists"
        case .checkNickname(let nickname):
            return "/users/nicknames/\(nickname)/exists"
        case .getTags:
            return "/tags"
        case .signUp:
            return "/users"
        case .editUserInfo:
            return "/user"
        case .getUserInfo(let userId):
            return "/users/\(userId)"
        case .follow(let userId), .unfollow(let userId):
            return "/users/\(userId)/followers"
        case .tagMatch(let userId):
            return "/users/\(userId)/tag-match-percentage"
        case .userLikeList(let id, _):
            return "/users/\(id)/liked-products"
        case .userBookmarkList(let id, _):
            return "/users/\(id)/bookmarked-products"
        case .noticeList:
            return "/notices"
        case .noticeDetail(let id):
            return "/notices/\(id)"
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .checkEmail, .checkNickname, .getTags, .getUserInfo,
                .noticeList, .noticeDetail, .follow, .unfollow, .tagMatch:
            return nil
        case .signUp(let parameters), .userBookmarkList(_, let parameters),
                .userLikeList(_ ,let parameters), .editUserInfo(let parameters):
            return parameters
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
        case .userLikeList(_, _), .userBookmarkList(_, _):
            return URLEncoding.default
        default:
            return JSONEncoding.default
        }
    }
    
    var fullURL: URL {
        var urlComponents = URLComponents(string: baseURL)!
        urlComponents.path += path
        return urlComponents.url!
    }
}
