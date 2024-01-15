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
    let modifyProduct: (Int, String?, String, String)? // reviewId, productImageUrl, productManufacturer, productName
    let writtenContent: String?
    let reviewImageUrls: [String]?
    let givenRating: Int?
    
    init(
        type: EditReviewType = .write,
        reviewViewModel: ReviewViewModel,
        fixedProduct: Product?,
        modifyProduct: (Int, String?, String, String)? = nil,
        writtenContent: String? = nil,
        reviewImageUrls: [String]? = nil,
        givenRating: Int? = nil
    ) {
        self.type = type
        self.reviewViewModel = reviewViewModel
        self.fixedProduct = fixedProduct
        self.modifyProduct = modifyProduct
        self.writtenContent = writtenContent
        self.reviewImageUrls = reviewImageUrls
        self.givenRating = givenRating
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
                        selectedProduct: $selectedProduct,
                        modifyProduct: modifyProduct
                    )
                    if selectedProduct != nil || type == .modify {
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
            if type == .modify {
                updateInfos()
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
                    if type == .write {
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
                    } else {
                        if let product = modifyProduct, !content.isEmpty {
                            let parameters: [String : Any] = [
                                "content": content,
                                "rating": rating + 1,
                                "imageUrls": []
                            ]
                            if imageSelection.images.isEmpty {
                                reviewViewModel.modifyReview(
                                    reviewID: product.0,
                                    parameters: parameters
                                )
                            } else {
                                reviewViewModel.modifyPhotoReview(
                                    reviewID: product.0,
                                    parameters: parameters,
                                    images: imageSelection.images
                                )
                            }
                        }
                    }
                }
            Spacer().frame(width: 20)
        }
        .frame(height: 44)
    }
    
    // 리뷰 수정일 경우, 이전 데이터 삽입
    private func updateInfos() {
        if let writtenContent = writtenContent {
            self.content = writtenContent
        }
        if let imageUrls = reviewImageUrls, !imageUrls.isEmpty {
            imageUrls.forEach { imageUrl in
                imageUrl.toImage { image in
                    if let image = image {
                        imageSelection.images.append(image)
                    }
                }
            }
       }
        if let givenRating = givenRating {
            self.rating = givenRating
        }
    }
}

enum EditReviewType {
    case write
    case modify
}
