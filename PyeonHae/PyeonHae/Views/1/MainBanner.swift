//
//  MainBanner.swift
//  PyeonHae
//
//  Created by 정건호 on 2023/01/21.
//

import SwiftUI

struct MainBanner: View {
    let images = [Image(name: .banner1), Image(name: .banner1), Image(name: .banner1)]
    
    @State var timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()
    @State var currentImage: Image?
    @State private var currentIndex = 0 {
        didSet {
            scrollToCurrentPage()
            withAnimation(.easeInOut) {
                currentImage = images[currentIndex]
            }
        }
    }
    @State private var contentOffsetX: CGFloat = 0
    @State private var titleViewWidth: CGFloat = 0
    let spacing: CGFloat = 20
    
    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .top) {
                VStack(alignment: .leading) {
                    if #available(iOS 16.0, *) {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: spacing) {
                                Group {
                                    ForEach(-1..<images.count + 1, id: \.self) { i in
                                        images[i < 0 ? images.count - 1 : (i >= images.count ? 0 : i)]
                                            .frame(width: titleViewWidth)
                                        
                                    }
                                }
                            }
                            .offset(x: contentOffsetX, y: 0)
                        }
                        .scrollDisabled(true)
                    } else {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: spacing) {
                                Group {
                                    ForEach(-1..<images.count + 1, id: \.self) { i in
                                        images[i < 0 ? images.count - 1 : (i >= images.count ? 0 : i)]
                                            .frame(width: titleViewWidth)
                                        
                                    }
                                }
                            }
                            .offset(x: contentOffsetX, y: 0)
                        }
                    }
                }
                ZStack(alignment: .center) {
                    RoundedRectangle(cornerRadius: 100)
                    Text("\(currentIndex+1)|\(images.count)")
                        .font(.pretendard(.regular, 12))
                        .foregroundColor(.white)
                }
                .foregroundColor(.rollingBannerColor)
                .frame(width: 50, height: 30)
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
                        timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
                    }
            )
            .onAppear {
                currentImage = images[0]
                titleViewWidth = geo.size.width - 70
                contentOffsetX = -titleViewWidth + spacing
            }
            .onReceive(timer) { _ in
                currentIndex += 1
            }
        }
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

struct MainBanner_Previews: PreviewProvider {
    static var previews: some View {
        MainBanner()
    }
}
