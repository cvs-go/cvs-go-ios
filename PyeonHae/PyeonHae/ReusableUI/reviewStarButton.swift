//
//  reviewStarButton.swift
//  PyeonHae
//
//  Created by 이주화 on 2023/05/28.
//

import SwiftUI

struct reviewStarButton: View {
    @Binding var rating: Int
    @State private var temp: Int = 0
    @State private var lastEdit: Int = 0
    
    var body: some View {
        VStack(spacing: 12) {
            Text(ratingText)
                .font(.pretendard(.regular, 14))
            
            HStack(spacing: 13) {
                ForEach(0..<5) { index in
                    Button(action: {
                        rating = index
                    }) {
                        Image(name: index <= rating ?  .redStar : .emptyStar)
                            .resizable()
                            .frame(width: 27, height: 27)
                            .foregroundColor(.yellow)
                            .gesture(
                                DragGesture()
                                    .onChanged { value in
                                        if temp == 0 {
                                            lastEdit = rating
                                        }
                                        let starWidth = 40
                                        let offset = value.translation.width
                                        let newRating = lastEdit + Int(offset / CGFloat(starWidth))
                                        rating = min(max(newRating, 0), 4)
                                        temp = rating - lastEdit
                                    }
                                    .onEnded { value in
                                        temp = 0
                                    }
                            )
                    }
                    
                }
            }
        }
        .padding()
    }
    
    var ratingText: String {
        let roundedRating = Int(rating)
        switch roundedRating {
        case 0:
            return "최악이었어요!"
        case 1:
            return "별로였어요."
        case 2:
            return "보통이에요."
        case 3:
            return "만족스러워요."
        case 4:
            return "최고예요!"
        default:
            return ""
        }
    }
}

