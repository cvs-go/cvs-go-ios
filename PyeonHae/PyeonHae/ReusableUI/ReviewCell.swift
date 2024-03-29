//
//  ReviewCell.swift
//  PyeonHae
//
//  Created by 정건호 on 2023/01/21.
//

import SwiftUI
import Kingfisher

struct ReviewProduct: View {
    @State private var isBookmarkedValue = false
    
    let imageUrl: String?
    let manufacturer: String
    let name: String
    let isBookmarked: Bool
    let bookmarkAction: () -> Void
    let unBookmarkAction: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 10)
                HStack {
                    Spacer().frame(width: 24)
                    if let imageUrl = imageUrl, let url = URL(string: imageUrl) {
                        KFImage(url)
                            .resizable()
                            .frame(width: 52, height: 52)
                    }
                    
                    VStack(alignment: .leading) {
                        Text(manufacturer)
                            .font(.pretendard(.regular, 14))
                            .foregroundColor(.grayscale70)
                        Text(name)
                            .font(.pretendard(.semiBold, 14))
                            .foregroundColor(.grayscale85)
                            .lineLimit(1)
                    }
                    Spacer()
                    Image(name: isBookmarkedValue ? .bookMarkFill : .bookMark)
                        .onTapGesture {
                            isBookmarkedValue.toggle()
                            isBookmarkedValue ? bookmarkAction() : unBookmarkAction()
                        }
                    Spacer().frame(width: 24)
                }
            }
            .frame(height: 64)
            .foregroundColor(.white)
        }
        .foregroundColor(Color.grayscale10)
        .onAppear {
            self.isBookmarkedValue = isBookmarked
        }
    }
}
