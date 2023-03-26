//
//  APIManager.swift
//  PyeonHae
//
//  Created by 정건호 on 2023/02/27.
//

import Foundation
import Alamofire
import Combine

class APIManager {
    
    private var session: Session = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 15
        let session = Alamofire.Session(
            configuration: configuration,
            delegate: SessionDelegate()
        )
        return session
    }()
    
    
    public func makeRequest(_ api: API) -> DataRequest {
        return self.session
            .request(
                api.fullURL,
                method: api.method,
                parameters: api.parameters,
                encoding: api.encoding
            )
    }
    
    func request<T: Codable>(for api: API) -> AnyPublisher<Result<T, Error>, Never> where T: Codable {
        return makeRequest(api)
            .validate()
            .publishData()
            .map { apiResult in
                switch apiResult.result {
                case .success(let data):
                    do {
                        let value = try JSONDecoder().decode(T.self, from: data)
                        return .success(value)
                    } catch {
                        return .failure(error)
                    }
                case .failure(let error):
                    return .failure(error)
                }
            }
            .eraseToAnyPublisher()
    }
}
