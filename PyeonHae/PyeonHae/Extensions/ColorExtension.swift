//
//  ColorExtension.swift
//  PyeonHae
//
//  Created by 정건호 on 2022/12/24.
//

import SwiftUI

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#")
        
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        
        let r = Double((rgb >> 16) & 0xFF) / 255.0
        let g = Double((rgb >>  8) & 0xFF) / 255.0
        let b = Double((rgb >>  0) & 0xFF) / 255.0
        self.init(red: r, green: g, blue: b)
    }
    
    static let red100 = Color(hex: "#F8594E")
    
    static let orange50 = Color(hex: "FFAD72")
    
    static let iris100 = Color(hex: "5D5FEF")
    
    static let grayscale10 = Color(hex: "F7F9FA")
    static let grayscale20 = Color(hex: "F3F6F8")
    static let grayscale25 = Color(hex: "E2E7EA")
    static let grayscale30 = Color(hex: "CAD2D8")
    static let grayscale50 = Color(hex: "939CA3")
    static let grayscale70 = Color(hex: "747E84")
    static let grayscale85 = Color(hex: "4C5257")
    static let grayscale100 = Color(hex: "26292C")
    
    static let systemGreen = Color(hex: "#08BE25")
    static let systemRed = Color(hex: "#E00D00")
    static let mineGray100 = Color(hex: "F6F6F6")
    static let mineGray400 = Color(hex: "9DA4AB")
    static let mineGray500 = Color(hex: "#89919A")
    static let mineGray900 = Color(hex: "#222222")
    static let borderColor = Color(hex: "#000000").opacity(0.05)
    
    static let rollingBannerColor = Color(hex: "#242424").opacity(0.5)
    
    static let cuColor = Color(hex: "#6C21D5")
    static let gsColor = Color(hex: "#0071B9")
    static let emart24Color = Color(hex: "#F9B233")
    static let sevenElevenColor = Color(hex: "#258E37")
    static let miniStopColor = Color(hex: "#213A8F")
}
