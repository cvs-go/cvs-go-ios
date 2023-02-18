//
//  ViewExtension.swift
//  PyeonHae
//
//  Created by 정건호 on 2023/01/28.
//

import SwiftUI

extension View {
    func scrollEnabled(_ enabled: Bool) -> some View {
        self.onAppear {
            UIScrollView.appearance().isScrollEnabled = enabled
        }
    }
    
    func toast(message: String,
               isShowing: Binding<Bool>,
               config: ToastMessage.Config) -> some View {
        self.modifier(
            ToastMessage(
                message: message,
                isShowing: isShowing,
                config: config
            )
        )
    }
}
