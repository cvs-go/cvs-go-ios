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
    var errorMessageSubject = PassthroughSubject<String, Never>()
    
    private var session: Session = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 15
        let session = Alamofire.Session(
            configuration: configuration,
            delegate: SessionDelegate(),
            interceptor: Interceptor()
        )
        return session
    }()
    
    public func makeRequest(_ api: API) -> DataRequest {
        return self.session
            .request(
                api.fullURL,
                method: api.method,
                parameters: api.parameters,
                encoding: api.encoding,
                headers: api.headers
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
                    if let data = apiResult.data,
                       let errorResponse = try? JSONDecoder().decode(ErrorResponse.self, from: data) {
                        self.errorMessageSubject.send(errorResponse.message)
                    }
                    return .failure(error)
                }
            }
            .eraseToAnyPublisher()
    }
    
    func upload<T: Codable>(api: ImageAPI) -> AnyPublisher<Result<T, Error>, Never> {
        return Future { promise in
            self.session.upload(multipartFormData: api.multipartFormData, to: api.fullURL, method: api.method, headers: api.headers)
                .validate()
                .responseDecodable(of: T.self) { response in
                    switch response.result {
                    case .success(let value):
                        promise(.success(.success(value)))
                    case .failure(let error):
                        if let data = response.data,
                           let errorResponse = try? JSONDecoder().decode(ErrorResponse.self, from: data) {
                            self.errorMessageSubject.send(errorResponse.message)
                        }
                        promise(.success(.failure(error)))
                    }
                }
        }
        .eraseToAnyPublisher()
    }

}
