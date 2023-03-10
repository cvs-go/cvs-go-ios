//
//  SelectProductView.swift
//  PyeonHae
//
//  Created by 이주화 on 2023/02/09.
//

import SwiftUI

struct SelectProductView: View {
    @State var isSelectProduct: Bool = false
    @Binding var showSearchProductView: Bool
    var body: some View {
        VStack {
            Button(action: {
                showSearchProductView.toggle()
            }) {
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
