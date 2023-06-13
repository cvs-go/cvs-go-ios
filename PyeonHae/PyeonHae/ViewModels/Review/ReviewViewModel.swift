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
    
    func writeReview(productID: Int, parameters: [String : Any]) {
        apiManager.request(for: ReviewAPI.writeReview(
            id: productID,
            parameters: parameters
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
        .store(in: &bag)
    }
    
    func writePhotoReview(productID: Int, parameters: [String : Any], images: [UIImage]) {
        let api = ImageAPI(images: images, folder: "review")
        apiManager.upload(api: api)
            .sink { (result: Result<ImageResponse, Error>) in
                print(result)
                switch result {
                case .success(let response):
                    print("성공")
                    var updatedParameters = parameters
                    updatedParameters["images"] = response.data
                    print(updatedParameters)
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
                case .failure(let error):
                    print("\(error)")
                    self.showAlertMessage = true
                }
            }
            .store(in: &bag)
    }
    
    
//    func writePhotoReview(productID: Int, parameters: [String : Any], images: [UIImage]) {
//        print("🥲")
//        let url = URL(string: Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String + "/images/review")!
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//
//        let boundary = "6o2knFse3p53ty9dmcQvWAIx1zInP11uCfbm"
//        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
//
//        var body = Data()
//
//        for (index, image) in images.enumerated() {
//            if let imageData = image.jpegData(compressionQuality: 0.8) {
//                let filename = "image\(index + 1).jpg"
//                let mimetype = "image/jpeg"
//
//                body.append("--\(boundary)\r\n".data(using: .utf8)!)
//                body.append("Content-Disposition: form-data; name=\"images\"; filename=\"\(filename)\"\r\n".data(using: .utf8)!)
//                body.append("Content-Type: \(mimetype)\r\n\r\n".data(using: .utf8)!)
//                body.append(imageData)
//                body.append("\r\n".data(using: .utf8)!)
//            }
//        }
//
//        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
//        request.httpBody = body
//
//        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
//            if let error = error {
//                print("Error: \(error)")
//                self.showAlertMessage = true
//                return
//            }
//
//            guard let data = data else {
//                print("No data received")
//                self.showAlertMessage = true
//                return
//            }
//
//            do {
//                print(String(data: data, encoding: .utf8))
//                let decoder = JSONDecoder()
//                let imageResponse = try decoder.decode(ImageResponse.self, from: data)
//                print("Success: \(imageResponse.data)")
//
//                var updatedParameters = parameters
//                updatedParameters["images"] = imageResponse.data
//
//            } catch {
//                print("Error decoding response: \(error)")
//                self.showAlertMessage = true
//            }
//        }
//        task.resume()
//    }
}
