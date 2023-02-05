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
        case close = "close"
        case arrowDown = "arrowDown"
        case arrowUp = "arrowUp"
        case arrowRight = "arrowRight"
        case logoCU = "logoCU"
        case logoGS = "logoGS"
        case logoSeven = "logoSeven"
        case logoEmart = "logoEmart"
        case logoMini = "logoMini"
        case sampleImage = "sampleImage"
        case logoOnePlusOne = "logoOnePlusOne"
        case logoTwoPlusOne = "logoTwoPlusOne"
        case infoCircle = "infoCircle"
        case redStar = "redStar"
        case yellowStar = "yellowStar"
        case rectengle = "rectengle"
        case homeIcon = "homeIcon"
        case reviewIcon = "reviewIcon"
        case searchIcon = "searchIcon"
        case profileIcon = "profileIcon"
        case banner1 = "banner1"
        case notification = "notification"
        case bookmark = "bookmark"
        case like = "like"
        case addSquare = "addSquare"
    }
    
    init(name imageName: ImageName) {
        self.init(imageName.rawValue)
    }
}
