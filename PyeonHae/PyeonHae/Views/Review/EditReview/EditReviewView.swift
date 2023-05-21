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
    @StateObject private var keyboardResponder = KeyboardResponder()
    @StateObject var imageSelection = ImageSelection()
    @Binding var showWriteView: Bool
    @State private var showToast = false
    @State private var showImagePicker = false
    @State private var showSearchProductView = false
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Color.white
                VStack(spacing: 0) {
                    reviewTopBar
                    SelectProductView(showSearchProductView: $showSearchProductView)
                    Rectangle()
                        .frame(height: 14)
                        .foregroundColor(Color.grayscale10)
                    EditLetterView()
                    if(keyboardResponder.currentHeight == 0) {
                        ReviewPhotoView(imageSelection: imageSelection, showToast: $showToast)
                    }
                }
                if(keyboardResponder.currentHeight > 0) {
                    VStack(spacing: 0) {
                        Spacer()
                        Divider()
                        Button(action: {
                            if imageSelection.images.count < 3 {
                                showImagePicker = true
                            } else {
                                showToast = true
                            }
                        }) {
                            HStack(spacing: 10) {
                                Image(name: .plusButton)
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                Text("사진 추가 (\(imageSelection.images.count)/3)")
                                    .font(.pretendard(.medium, 16))
                                    .foregroundColor(.grayscale70)
                                Spacer()
                            }
                            .padding(.horizontal, 22)
                            .padding(.vertical, 12)
                            .frame(height: 44)
                            .background(Color.grayscale20)
                        }
                    }
                }
            }
            .toast(message: "사진은 최대 3장까지 추가할 수 있습니다.", isShowing: $showToast, config: .init())
        }
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(images: $imageSelection.images)
        }
        .blur(radius: showSearchProductView ? 2 : 0)
        .bottomSheet(isPresented: $showSearchProductView) {
            SearchProductView(showSearchProductView: $showSearchProductView)
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
