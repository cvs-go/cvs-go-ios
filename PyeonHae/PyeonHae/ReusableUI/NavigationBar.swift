//
//  NavigationBar.swift
//  PyeonHae
//
//  Created by 정건호 on 1/9/24.
//

import SwiftUI

struct NavigationBar: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    let type: BackButtonType
    let title: String
    @Binding var isVisiable: Bool
    
    init(
        type: BackButtonType = .arrow,
        title: String = String(),
        isVisiable: Binding<Bool> = .constant(true)
    ) {
        self.type = type
        self.title = title
        self._isVisiable = isVisiable
    }
    
    var body: some View {
        HStack(spacing: 0) {
            Spacer().frame(width: 14)
            Image(name: type == .arrow ? .arrowLeft : .close)
                .onTapGesture {
                    self.presentationMode.wrappedValue.dismiss()
                }
            Spacer().frame(width: 9)
            if !title.isEmpty && isVisiable {
                Text(title)
                    .font(.pretendard(.bold, 20))
                    .foregroundColor(.grayscale100)
            }
            Spacer()
        }
        .frame(height: 44)
        .navigationBarBackButtonHidden()
    }
}

enum BackButtonType {
    case arrow
    case close
}
