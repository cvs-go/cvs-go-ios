//
//  ImageAPI.swift
//  PyeonHae
//
//  Created by 이주화 on 2023/06/11.
//

import Foundation
import Alamofire
import UIKit

enum FolderType: String {
    case review = "review"
    case profile = "profile"
}

struct ImageAPI: API {
    let images: [UIImage]
    let folder: FolderType
    
    var method: HTTPMethod {
        return .post
    }
    
    var path: String {
        return "/images/\(folder.rawValue)"
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
    
    func resizeImage(image: UIImage, maxFileSizeKB: Int) -> Data? {
        let maxSize: CGFloat = CGFloat(maxFileSizeKB) * 1024.0
        var compression: CGFloat = 1.0
        var output: Data? = image.jpegData(compressionQuality: compression)
        while (output?.count ?? 0) > Int(maxSize) && compression > 0 {
            compression -= 0.1
            output = image.jpegData(compressionQuality: compression)
        }
        return output
    }

    var multipartFormData: (MultipartFormData) -> Void {
        return { formData in
            for (index, image) in self.images.enumerated() {
                if let imageData = resizeImage(image: image, maxFileSizeKB: 10) {
                    let fileName = "images\(index + 1).jpeg"
                    formData.append(imageData, withName: "images", fileName: fileName, mimeType: "image/jpeg")
                }
            }
        }
    }
}
