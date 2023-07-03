//
//  ImageDetailView.swift
//  PyeonHae
//
//  Created by 정건호 on 2023/07/03.
//

import SwiftUI
import Kingfisher

struct ImageDetailView: View {
    @Binding var imageUrl: String
    let dismissAction: () -> Void
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Image(name: .close)
                    .onTapGesture {
                        dismissAction()
                    }
                Spacer().frame(width: 24)
            }
            Spacer().frame(height: 24)
            if let url = URL(string: imageUrl) {
                GeometryReader { geometry in
                    KFImage(url)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .cornerRadius(10)
                }
                .padding(.all, 24)
            } else {
                Text("이미지를 불러올 수 없습니다.")
            }
            Spacer()
        }
    }
}
