//
//  ReviewTextCell.swift
//  PyeonHae
//
//  Created by 이주화 on 2023/03/01.
//

import SwiftUI
import Kingfisher

struct ReviewContents: View {
    let rating: Int
    let imageUrls: [String]?
    let content: String
    let likeCount: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack(spacing: 0) {
                ForEach(0..<5) { index in
                    Image(name: rating >= index ? .yellowStar : .emptyStar)
                }
            }
            if let imageUrls = imageUrls {
                HStack(spacing: 6) {
                    ForEach(imageUrls, id: \.self) { imageUrl in
                        if let url = URL(string: imageUrl) {
                            KFImage(url)
                                .resizable()
                                .frame(width: 120, height: 120)
                                .cornerRadius(10)
                        }
                    }
                }
            }
            Text(content)
                .lineLimit(2)
                .font(.pretendard(.regular, 14))
                .foregroundColor(.grayscale85)
                .padding(.vertical, 3)
            HStack(spacing: 2) {
                Image(name: .like)
                Text(String(likeCount))
                    .font(.pretendard(.semiBold, 12))
                    .foregroundColor(.grayscale85)
            }
            .padding(EdgeInsets(top: 4, leading: 12, bottom: 4, trailing: 12))
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.grayscale30)
            )
        }
    }
}
