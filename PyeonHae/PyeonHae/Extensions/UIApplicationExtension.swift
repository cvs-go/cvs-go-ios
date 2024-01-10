//
//  UIApplicationExtension.swift
//  PyeonHae
//
//  Created by 정건호 on 1/10/24.
//

import UIKit

extension UIApplication {
    static var keyWindow: UIWindow? {
        self.shared
            .connectedScenes.lazy
            .compactMap { $0.activationState == .foregroundActive ? ($0 as? UIWindowScene) : nil }
            .first(where: { $0.keyWindow != nil })?
            .keyWindow
    }
}
