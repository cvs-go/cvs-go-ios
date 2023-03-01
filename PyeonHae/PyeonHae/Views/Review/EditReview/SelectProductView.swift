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
