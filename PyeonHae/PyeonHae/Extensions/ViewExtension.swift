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
    
    func showAlert(
        title: String = String(),
        message: String,
        showAlert: Binding<Bool>
    ) -> some View {
        self.alert(isPresented: showAlert) {
            Alert(
                title: Text(title),
                message: Text(message),
                dismissButton: .default(Text("확인"))
            )
        }
    }
    
    func showDeleteAlert(
        title: String = String(),
        message: String,
        showAlert: Binding<Bool>,
        deleteAction: @escaping () -> Void
    ) -> some View {
        self.alert(isPresented: showAlert) {
            Alert(
                title: Text(title),
                message: Text(message),
                primaryButton: .default(Text("취소")),
                secondaryButton: .destructive(Text("삭제"), action: deleteAction)
            )
        }
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
    
    func hidden(_ shouldHide: Bool) -> some View {
        opacity(shouldHide ? 0 : 1)
    }
}
