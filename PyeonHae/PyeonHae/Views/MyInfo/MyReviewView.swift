//
//  MyReviewView.swift
//  PyeonHae
//
//  Created by 정건호 on 2023/07/27.
//

import SwiftUI

struct MyReviewView: View {
    var body: some View {
        VStack(spacing: 0) {
            Spacer().frame(height: 12)
            HStack {
                HStack(spacing: 2) {
                    Text("작성한 리뷰")
                        .font(.pretendard(.regular, 12))
                        .foregroundColor(.grayscale85)
                    Text("14개")
                        .font(.pretendard(.bold, 12))
                        .foregroundColor(.grayscale85)
                    Spacer()
                    HStack(spacing: 6) {
                        Text("최신순")
                            .font(.pretendard(.regular, 12))
                            .foregroundColor(.grayscale85)
                        Image(name: .invertedTriangle)
                    }
                    .frame(width: 64.5, height: 26)
                    .background(Color.grayscale10)
                    .cornerRadius(10)
                }
            }
            .frame(height: 40)
        }
        .padding(.horizontal,20)
        ForEach(0..<10) { _ in
            VStack {
                //ReviewCell()
            }
            Color.grayscale30.opacity(0.5).frame(height: 1)
                .padding(.bottom, 16)
        }
        .padding(.horizontal,10)
    }
}

struct MyReviewView_Previews: PreviewProvider {
    static var previews: some View {
        MyReviewView()
    }
}
