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
               config: ToastMessage.Config = .init()
    ) -> some View {
        self.modifier(
            ToastMessage(
                message: message,
                isShowing: isShowing,
                config: config
            )
        )
    }
    
    func bottomSheet<Content: View>(
        isPresented: Binding<Bool>,
        @ViewBuilder content: @escaping () -> Content) -> some View {
        self.overlay(
            Group {
                if isPresented.wrappedValue {
                    BottomSheet(
                        isPresented: isPresented,
                        content: content
                    )
                }
            }
        )
    }
    
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}
