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
    static let grayscale30 = Color(hex: "CAD2D8")
    static let grayscale50 = Color(hex: "939CA3")
    static let grayscale70 = Color(hex: "747E84")
    static let grayscale85 = Color(hex: "4C5257")
    static let grayscale100 = Color(hex: "26292C")
    
    static let systemGreen = Color(hex: "#08BE25")
    static let systemRed = Color(hex: "#E00D00")
}
