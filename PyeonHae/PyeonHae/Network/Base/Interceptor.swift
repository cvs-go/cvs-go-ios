//
//  Interceptor.swift
//  PyeonHae
//
//  Created by 정건호 on 2023/03/25.
//

import Foundation
import Alamofire

class Interceptor: RequestInterceptor {
    private let maxRetryCount = 3
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var token = UserShared.accessToken
        
        // 토큰 재발급 api인 경우에는 header에 refreshToken이 들어감
        if urlRequest.url?.absoluteString.contains("/auth/tokens") == true {
            token = UserShared.refreshToken
        }
        
        if token.isEmpty {
            completion(.success(urlRequest))
            return
        }
        var urlRequest = urlRequest
        urlRequest.setValue("Bearer " + token, forHTTPHeaderField: "Authorization")
        completion(.success(urlRequest))
    }
    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        // TODO: 토큰 만료 시, 토큰 재발급 로직 구현
    }
}


