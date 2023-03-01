//
//  DetailItemView.swift
//  PyeonHae
//
//  Created by 이주화 on 2023/03/01.
//

import SwiftUI

struct DetailItemView: View {
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                DetailItemViewTopBar
                ScrollView {
                    ItemDetailView()
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
        }
        .frame(height: 44)
    }
}

struct DetailItemView_Previews: PreviewProvider {
    static var previews: some View {
        DetailItemView()
    }
}

