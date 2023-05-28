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
        case bookMark = "bookMark"
        case like = "like"
        case addSquare = "addSquare"
        case invertedTriangle = "invertedTriangle"
        case grayCircle = "grayCircle"
        case statistics = "statistics"
        case emptyImage = "emptyImage"
        case fillLike = "fillLike"
        case plusButton = "plusButton"
        case addPhoto = "addPhoto"
        case deletePhoto = "deletePhoto"
        case bookMarkFill = "bookMarkFill"
        case heartMark = "heartMark"
        case heartMarkFill = "heartMarkFill"
        case arrowLeft = "arrowLeft"
        case pyeonHaeImage = "pyeonHaeImage"
        case backgroundImage = "backgroundImage"
        case defalutUserImage = "defalutUserImage"
        case setting = "setting"
        case editPen = "editPen"
        case PriceScrollButton = "PriceScrollButton"
        case emptyStar = "emptyStar"
        
        case foodImage = "foodImage"
        case instantFoodImage = "instantFoodImage"
        case snackImage = "snackImage"
        case icecreamImage = "icecreamImage"
        case freshFoodImage = "freshFoodImage"
        case dairyProductImage = "dairyProductImage"
        case beverageImage = "beverageImage"
        case etcImage = "etcImage"
        
    }
    
    init(name imageName: ImageName) {
        self.init(imageName.rawValue)
    }
}
