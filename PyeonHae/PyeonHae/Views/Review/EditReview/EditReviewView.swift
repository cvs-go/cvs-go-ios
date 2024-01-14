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
    private let type: EditReviewType
    @ObservedObject var reviewViewModel: ReviewViewModel
    
    @StateObject private var keyboardResponder = KeyboardResponder()
    @StateObject var imageSelection = ImageSelection()
    
    @State private var content = String()
    @State var rating: Int = 2
    
    @State private var showToast = false
    @State private var showImagePicker = false
    @State private var showSearchProductView = false
    @State private var selectedProduct: Product? = nil
    
    @FocusState private var contentIsFocused: Bool
    
    let fixedProduct: Product?
    
    init(
        type: EditReviewType = .write,
        reviewViewModel: ReviewViewModel,
        fixedProduct: Product?
    ) {
        self.type = type
        self.reviewViewModel = reviewViewModel
        self.fixedProduct = fixedProduct
    }
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Color.white
                VStack(spacing: 0) {
                    reviewTopBar
                    SelectProductView(
                        type: type,
                        showSearchProductView: $showSearchProductView,
                        selectedProduct: $selectedProduct
                    )
                    if selectedProduct != nil {
                        reviewStarButton(rating: self.$rating)
                    }
                    Rectangle()
                        .frame(height: 14)
                        .foregroundColor(Color.grayscale10)
                    EditLetterView(content: $content)
                        .focused($contentIsFocused)
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
                
                if reviewViewModel.isLoading {
                    LoadingView()
                }
            }
            .toast(
                message: "사진은 최대 3장까지 추가할 수 있습니다.",
                isShowing: $showToast
            )
            .showAlert(
                message: reviewViewModel.errorMessage,
                showAlert: $reviewViewModel.showAlertMessage
            )
        }
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(images: $imageSelection.images)
        }
        .blur(radius: showSearchProductView ? 2 : 0)
        .bottomSheet(isPresented: $showSearchProductView) {
            SearchProductView(
                showSearchProductView: $showSearchProductView,
                selectedProduct: $selectedProduct
            )
        }
        .onAppear {
            if let fixedProduct = fixedProduct {
                self.selectedProduct = fixedProduct
            }
        }
    }
    
    var reviewTopBar: some View {
        HStack(spacing: 0) {
            Spacer().frame(width: 14)
            Image(name: .close)
                .onTapGesture {
                    reviewViewModel.showEditView = false
                }
            Spacer().frame(width: 9)
            Text(type == .write ? "리뷰 작성" : "리뷰 수정")
                .font(.pretendard(.bold, 20))
                .foregroundColor(.grayscale100)
            Spacer()
            Text("완료")
                .font(.pretendard(.bold, 16))
                .foregroundColor(
                    content.isEmpty || selectedProduct == nil
                    ? .grayscale50
                    : .red100
                )
                .onTapGesture {
                    self.contentIsFocused = false
                    self.reviewViewModel.isLoading = true
                    if let product = selectedProduct, !content.isEmpty {
                        let parameters: [String : Any] = [
                            "content": content,
                            "rating": rating + 1
                        ]
                        
                        if imageSelection.images.isEmpty {
                            reviewViewModel.writeReview(
                                productID: product.productId,
                                parameters: parameters
                            )
                        } else {
                            reviewViewModel.writePhotoReview(
                                productID: product.productId,
                                parameters: parameters,
                                images: imageSelection.images
                            )
                        }
                    }
                }
            Spacer().frame(width: 20)
        }
        .frame(height: 44)
    }
}

enum EditReviewType {
    case write
    case modify
}
