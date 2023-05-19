//
//  CustomToggle.swift
//  PyeonHae
//
//  Created by 이주화 on 2023/05/18.
//

import SwiftUI

struct CustomToggleStyle: ToggleStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        HStack {
            Spacer()

            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(Color.gray.opacity(0.2))
                .frame(width: 34, height: 18)
                .overlay(
                    Circle()
                        .fill(Color.white)
                        .padding(4)
                        .offset(x: configuration.isOn ? 10 : -10, y: 0)
                )
                .onTapGesture {
                    withAnimation(.linear(duration: 0.2)) {
                        configuration.isOn.toggle()
                    }
                }
        }
    }
}
