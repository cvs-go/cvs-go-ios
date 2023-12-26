//
//  LoadingView.swift
//  PyeonHae
//
//  Created by 정건호 on 2023/05/21.
//

import SwiftUI
import SwiftyGif

struct LoadingView: View {
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            LoadingGIF()
                .frame(width: 44, height: 44)
            Spacer().frame(height: 21)
            Text("로딩중")
                .font(.pretendard(.bold, 16))
                .foregroundColor(.grayscale100)
            Spacer().frame(height: 8)
            Text("잠시만 기다려주세요")
                .font(.pretendard(.regular, 14))
                .foregroundColor(.grayscale85)
        }.navigationBarBackButtonHidden()
    }
}

struct LoadingGIF: UIViewRepresentable {
    func makeUIView(context: Context) -> UIImageView {
        var imageView = UIImageView()
        do {
            let gif = try UIImage(gifName: "LoadingGIF")
            imageView = UIImageView(gifImage: gif, manager: .defaultManager, loopCount: -1)
        } catch {}
        return imageView
    }

    func updateUIView(_ uiView: UIImageView, context: Context) {}
}
