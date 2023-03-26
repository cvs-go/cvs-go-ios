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
        guard let response = request.task?.response as? HTTPURLResponse,
              response.statusCode == 401,
              request.retryCount < maxRetryCount
        else {
            completion(.doNotRetryWithError(error))
            return
        }
        
        refreshToken { success in
            if success {
                completion(.retry)
            } else {
                completion(.doNotRetryWithError(error))
            }
        }
    }
    
    func refreshToken(completion: @escaping (Bool) -> Void) {
        let refreshTokenAPI = AuthAPI.tokens
        let request = AF.request(
            refreshTokenAPI.fullURL,
            method: refreshTokenAPI.method,
            parameters: refreshTokenAPI.parameters,
            encoding: refreshTokenAPI.encoding
        )
        
        request.responseJSON { response in
            switch response.result {
            case .success(let data):
                guard let json = data as? [String: Any],
                      let newAccessToken = json["access_token"] as? String,
                      let newRefreshToken = json["refresh_token"] as? String
                else {
                    completion(false)
                    return
                }
                
                UserShared.accessToken = newAccessToken
                UserShared.refreshToken = newRefreshToken
                completion(true)
                
            case .failure:
                completion(false)
            }
        }
    }
}


