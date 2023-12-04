//
//  MainBanner.swift
//  PyeonHae
//
//  Created by 정건호 on 2023/01/21.
//

import SwiftUI

struct MainBanner: View {
    @Binding var promotions: [PromotionContent]
    @State private var images: [Image] = []
    
    @State var timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()
    @State var currentImage: Image?
    @State private var currentIndex = 0 {
        didSet {
            scrollToCurrentPage()
            withAnimation(.easeInOut) {
                currentImage = images[safe: currentIndex]
            }
        }
    }
    @State private var contentOffsetX: CGFloat = 0
    @State private var titleViewWidth: CGFloat = 0
    let spacing: CGFloat = 10
    
    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .top) {
                VStack(alignment: .leading) {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: spacing) {
                            Group {
                                ForEach(-1..<images.count + 1, id: \.self) { i in
                                    images[safe: i < 0 ? images.count - 1 : (i >= images.count ? 0 : i)]?
                                        .resizable()
                                        .frame(width: titleViewWidth, height: 200)
                                        .cornerRadius(10)
                                }
                            }
                        }
                        .offset(x: contentOffsetX - 20, y: 0)
                    }
                    .disabled(true)
                    .offset(x: 20)
                }
                ZStack(alignment: .center) {
                    RoundedRectangle(cornerRadius: 100)
                    Text("\(currentIndex+1) | \(images.count)")
                        .font(.pretendard(.regular, 12))
                        .foregroundColor(.white)
                }
                .foregroundColor(.rollingBannerColor)
                .frame(width: 51, height: 20)
                .offset(x: -(geo.size.width / 2) + 56, y: 9)
            }
            .gesture(
                DragGesture()
                    .onEnded { value in
                        if value.translation.width < 0 {
                            currentIndex += 1
                        } else if value.translation.width > 0 {
                            currentIndex -= 1
                        }
                        timer.upstream.connect().cancel()
                        timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()
                    }
            )
            .onAppear {
                currentImage = images[safe: 0]
                titleViewWidth = geo.size.width - 70
                contentOffsetX = -titleViewWidth + spacing
            }
            .onReceive(timer) { _ in
                currentIndex += 1
            }
            .onChange(of: promotions) { _ in
                promotions.forEach { promotion in
                    promotion.imageUrl.toImage { image in
                        if let image = image {
                            images.append(Image(uiImage: image))
                        }
                    }
                }
            }
        }
        .frame(height: 200)
        .padding(.vertical, 20)
        .background(Color.white)
    }
    
    private func scrollToCurrentPage() {
        if currentIndex == images.count {
            contentOffsetX = 0
            currentIndex = 0
        } else if currentIndex < 0 {
            contentOffsetX = -titleViewWidth * CGFloat(images.count + 1) + spacing * CGFloat(images.count - 1)
            currentIndex = images.count - 1
        }
        
        withAnimation {
            contentOffsetX = -titleViewWidth * CGFloat(currentIndex + 1) - spacing * CGFloat(currentIndex - 1)
        }
    }
}
