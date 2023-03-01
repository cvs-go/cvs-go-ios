//
//  BottomSheet.swift
//  PyeonHae
//
//  Created by 정건호 on 2023/02/26.
//

import SwiftUI

private struct Distances {
    static let hidden: CGFloat = (UIWindow().screen.bounds.height - 93) / 2
    static let dismiss: CGFloat = 200
}

struct BottomSheet<Content: View>: View {
    @Binding var isPresented: Bool
    @ViewBuilder let content: Content
    @State private var translation = Distances.hidden
    
    var body: some View {
        ZStack {
            Color.black
                .opacity(0.4)
                .onTapGesture {
                    isPresented = false
                }
            
            VStack {
                Spacer()
                contentView
                    .offset(y: translation)
                    .animation(.interactiveSpring(), value: isPresented)
                    .animation(.interactiveSpring(), value: translation)
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                guard value.translation.height >= 0 else { return }
                                translation = value.translation.height
                            }
                            .onEnded { value in
                                if value.translation.height > Distances.dismiss {
                                    translation = Distances.hidden
                                    isPresented = false
                                } else {
                                    translation = 0
                                }
                            }
                    )
            }
        }
        .ignoresSafeArea()
        .onAppear {
            withAnimation {
                translation = 0
            }
        }
    }
    
    private var contentView: some View {
        VStack(spacing: 0) {
            handle
                .padding(.top, 10)
            content
                .padding(.top, 13)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: UIWindow().screen.bounds.height - 93)
        .background(Color.white)
        .cornerRadius(24, corners: [.topLeft, .topRight])
        .shadow(color: Color.gray, radius: 2, x: 0, y: -2)
    }
    
    private var handle: some View {
        RoundedRectangle(cornerRadius: 3)
            .fill(Color.grayscale30)
            .frame(width: 44, height: 4)
    }
}
