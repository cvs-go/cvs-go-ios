//
//  UIDeviceExtension.swift
//  PyeonHae
//
//  Created by 정건호 on 1/1/24.
//

import UIKit

extension UIDevice {
    var hasNotch: Bool {
        let bottom = UIApplication.keyWindow?.safeAreaInsets.bottom ?? 0
        return bottom > 0
    }
}
