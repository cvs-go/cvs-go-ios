//
//  ImageAPI.swift
//  PyeonHae
//
//  Created by 이주화 on 2023/06/11.
//

import Foundation
import Alamofire
import UIKit

struct ImageAPI: API {
    let images: [UIImage]
    let folder: String
    
    var method: HTTPMethod {
        return .post
    }
    
    var path: String {
        return "/api/images/\(folder)"
    }
    
    var parameters: [String: Any]? {
        return nil
    }
    
    var encoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    var fullURL: URL {
        var urlComponents = URLComponents(string: baseURL)!
        urlComponents.path += path
        return urlComponents.url!
    }
    
    var multipartFormData: (MultipartFormData) -> Void {
        return { formData in
            for (index, image) in self.images.enumerated() {
                if let imageData = image.jpegData(compressionQuality: 0.8) {
                    let fileName = "image\(index + 1).jpg"
                    formData.append(imageData, withName: "images", fileName: fileName, mimeType: "image/jpeg")
                }
            }
        }
    }
}
