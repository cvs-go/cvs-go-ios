//
//  DetailItemView.swift
//  PyeonHae
//
//  Created by 이주화 on 2023/03/01.
//

import SwiftUI

struct DetailItemView: View {
    
    @State private var isReviewButtonVisible = false
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                DetailItemViewTopBar
                ScrollView {
                    ItemDetailView()
                        .background(
                            GeometryReader { geometry -> Color in
                                let maxY = geometry.frame(in: .global).midY
                              DispatchQueue.main.async {
                                    isReviewButtonVisible = maxY <= 0
                                }
                                return Color.clear
                            }
                        )
                    Rectangle()
                        .frame(height: 14)
                        .foregroundColor(Color.grayscale10)
                    DetailItemReviewsView()
                    Rectangle()
                        .frame(height: 30)
                        .foregroundColor(Color.white)
                }
            }
                VStack{
                    Spacer()
                    Button(action: {
                    
                    }){
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(.red100)
                            Text("리뷰 작성")
                                .font(.pretendard(.bold, 18))
                                .foregroundColor(.white)
                        }
                        .frame(height: 50)
                        .padding(.horizontal, 20)
                    }
                }
        }
    }
    var DetailItemViewTopBar: some View {
        HStack(spacing: 0) {
            Spacer().frame(width: 14)
            Image(name: .arrowLeft)
            Spacer().frame(width: 18)
            if isReviewButtonVisible {
                Text("백두마운틴바")
                    .font(.pretendard(.bold, 18))
                    .foregroundColor(.black)
            }
            Spacer()
        }
        .frame(height: 44)
    }
}

struct ScrollViewOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}


struct DetailItemView_Previews: PreviewProvider {
    static var previews: some View {
        DetailItemView()
    }
}

