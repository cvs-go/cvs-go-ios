//
//  EditReviewView.swift
//  PyeonHae
//
//  Created by 이주화 on 2023/02/09.
//

import SwiftUI

class ImageSelection: ObservableObject {
    @Published var images: [UIImage] = []
}

struct EditReviewView: View {
    @StateObject var imageSelection = ImageSelection()
    @Binding var showWriteView: Bool
    @State private var showToast = false
    
    var body: some View {
        GeometryReader { geo in
            VStack(spacing: 0) {
                reviewTopBar
                SelectProductView()
                Rectangle()
                    .frame(height: 14)
                    .foregroundColor(Color.grayscale10)
                EditLetterView()
                ReviewPhotoView(imageSelection: imageSelection, showToast: $showToast)
            }
            .background(Color.white)
            .toast(message: "사진은 최대 3장까지 추가할 수 있습니다.", isShowing: $showToast, config: .init())
        }
    }
    
    var reviewTopBar: some View {
        HStack(spacing: 0) {
            Spacer().frame(width: 14)
            Image(name: .close)
                .onTapGesture {
                    showWriteView = false
                }
            Spacer().frame(width: 9)
            Text("리뷰 작성")
                .font(.pretendard(.bold, 20))
                .foregroundColor(.grayscale100)
            Spacer()
            Text("완료")
                .font(.pretendard(.bold, 16))
                .foregroundColor(.grayscale50)
            Spacer().frame(width: 20)
        }
        .frame(height: 44)
    }
}
