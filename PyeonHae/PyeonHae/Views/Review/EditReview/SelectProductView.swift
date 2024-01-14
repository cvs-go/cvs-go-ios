//
//  SelectProductView.swift
//  PyeonHae
//
//  Created by 이주화 on 2023/02/09.
//

import SwiftUI
import Kingfisher

struct SelectProductView: View {
    let type: EditReviewType
    @State var isSelectProduct: Bool = false
    @Binding var showSearchProductView: Bool
    @Binding var selectedProduct: Product?
    let modifyProduct: (Int, String?, String, String)? // reviewId, productImageUrl, productManufacturer, productName
    
    init(
        type: EditReviewType,
        showSearchProductView: Binding<Bool>,
        selectedProduct: Binding<Product?> = .constant(nil),
        modifyProduct: (Int, String?, String, String)? = nil
    ) {
        self.type = type
        self._showSearchProductView = showSearchProductView
        self._selectedProduct = selectedProduct
        self.modifyProduct = modifyProduct
    }
    
    var body: some View {
        VStack {
            if type == .modify && modifyProduct != nil {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.grayscale30.opacity(0.5), lineWidth: 1)
                    HStack {
                        Spacer().frame(width: 6)
                        if let modifyProduct = modifyProduct {
                            if let url = modifyProduct.1, let imageUrl = URL(string: url) {
                                KFImage(imageUrl)
                                    .resizable()
                                    .frame(width: 52, height: 52)
                                    .background(Color.grayscale10)
                            }
                            VStack(alignment: .leading, spacing: 0) {
                                Text(modifyProduct.2)
                                    .font(.pretendard(.regular, 12))
                                    .foregroundColor(.grayscale50)
                                    .frame(height: 20)
                                Text(modifyProduct.3)
                                    .lineLimit(1)
                                    .font(.pretendard(.semiBold, 14))
                                    .foregroundColor(.grayscale85)
                                    .frame(height: 20)
                            }
                            Spacer()
                        }
                    }
                }
                .background(Color.grayscale10)
                .padding(.horizontal, 12)
                .frame(height: 64)
            } else {
                Button(action: {
                    showSearchProductView.toggle()
                }) {
                    if let selectedProduct = selectedProduct {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.grayscale30.opacity(0.5), lineWidth: 1)
                            HStack {
                                Spacer().frame(width: 6)
                                if let url = selectedProduct.productImageUrl, let imageUrl = URL(string: url) {
                                    KFImage(imageUrl)
                                        .resizable()
                                        .frame(width: 52, height: 52)
                                        .background(Color.grayscale10)
                                }
                                VStack(alignment: .leading, spacing: 0) {
                                    Text(selectedProduct.manufacturerName)
                                        .font(.pretendard(.regular, 12))
                                        .foregroundColor(.grayscale50)
                                        .frame(height: 20)
                                    Text(selectedProduct.productName)
                                        .lineLimit(1)
                                        .font(.pretendard(.semiBold, 14))
                                        .foregroundColor(.grayscale85)
                                        .frame(height: 20)
                                }
                                Spacer()
                                Image(name: .close)
                                    .onTapGesture {
                                        self.selectedProduct = nil
                                    }
                                Spacer().frame(width: 16)
                            }
                        }
                        .background(Color.grayscale10)
                        .padding(.horizontal, 12)
                        .frame(height: 64)
                    } else {
                        if type == .write {
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(style: StrokeStyle(lineWidth: 1, dash: [3]))
                                    .foregroundColor(Color.grayscale30)
                                HStack {
                                    Image(name: .plusButton)
                                    Text("리뷰를 남길 제품을 선택해주세요.")
                                        .font(.pretendard(.regular, 14))
                                        .foregroundColor(.grayscale70)
                                }
                            }
                            .background(Color.grayscale10)
                            .padding(.horizontal, 12)
                            .frame(height: 64)
                        } else {
                            
                        }
                    }
                }
            }
        }
        .padding(.all, 16)
        .background(Color.white)
    }
}

//제품 선택된 이후에 보여줄 뷰도 필요해서 삭제하면 안될듯
//ZStack {
//    RoundedRectangle(cornerRadius: 10)
//        .stroke(Color.grayscale30, lineWidth: 1)
//    HStack {
//        Image(name: .sampleImage)
//            .resizable()
//            .frame(width: 52, height: 52)
//            .padding(.leading, 6)
//        VStack(alignment: .leading) {
//            Text("코카콜라")
//                .font(.pretendard(.regular, 12))
//                .foregroundColor(.grayscale50)
//            Text("제품 이름 한줄에서 끝내자")
//                .font(.pretendard(.semiBold, 14))
//                .foregroundColor(.grayscale85)
//        }
//        Spacer()
//        Button(action: {
//            isSelectProduct.toggle()
//        }) {
//            Image(name: .close)
//                .resizable()
//                .frame(width: 24, height: 24)
//                .padding(.trailing, 16)
//        }
//    }
