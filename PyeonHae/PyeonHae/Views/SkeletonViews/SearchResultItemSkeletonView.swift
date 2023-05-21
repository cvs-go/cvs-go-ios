//
//  SearchResultItemSkeletonView.swift
//  PyeonHae
//
//  Created by 정건호 on 2023/05/21.
//

import SwiftUI
import EasySkeleton

struct SearchResultItemSkeletonView: View {
    @Binding var isLoading: Bool
    
    var body: some View {
        HStack(spacing: 0) {
            Spacer().frame(width: 20)
            Text(String())
                .cornerRadius(10)
                .frame(width: 120, height: 120)
                .skeletonable()
                .skeletonCornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.black, lineWidth: 1)
                        .opacity(0.05)
                )
            Spacer().frame(width: 15)
            VStack(alignment: .leading, spacing: 0) {
                Spacer().frame(height: 5)
                Text(String())
                    .frame(width: 78, height: 10)
                    .skeletonable()
                Spacer().frame(height: 6)
                Text(String())
                    .frame(width: 127, height: 16)
                    .skeletonable()
                Spacer().frame(height: 6)
                Text(String())
                    .frame(width: 58, height: 16)
                    .skeletonable()
                Spacer().frame(height: 11)
                HStack(spacing: 6) {
                    Text(String())
                        .frame(width: 35, height: 16)
                        .skeletonable()
                    Text(String())
                        .frame(width: 113, height: 16)
                        .skeletonable()
                }
                Spacer().frame(height: 10)
                HStack(spacing: 4) {
                    ForEach(1...5, id: \.self) { _ in
                        Text(String())
                            .cornerRadius(10)
                            .frame(width: 16, height: 16)
                            .skeletonable()
                            .skeletonCornerRadius(10)
                    }
                }
            }
            Spacer()
        }
    }
}
