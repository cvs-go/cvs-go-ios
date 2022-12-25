//
//  ImageExtension.swift
//  PyeonHae
//
//  Created by 정건호 on 2022/12/25.
//

import SwiftUI

extension Image {
    enum ImageName: String {
        case eyeOff = "eyeOff"
        case eyeOn = "eyeOn"
        case kakaoLogin = "kakaoLogin"
        case naverLogin = "naverLogin"
        case appleLogin = "appleLogin"
    }
    
    init(name imageName: ImageName) {
        self.init(imageName.rawValue)
    }
}
