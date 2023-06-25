//
//  MyInfoView.swift
//  PyeonHae
//
//  Created by 이주화 on 2023/04/23.
//

import SwiftUI

struct MyInfoView: View {
    @State private var selectedTab: Int = 0
    let tabItems = ["리뷰", "좋아요", "북마크"]
    let itemText: [String] = ["새로운 리뷰 ", "좋아요한 리뷰", "북마크한 리뷰"]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                HStack {
                    Text("내정보")
                        .font(.pretendard(.bold, 20))
                        .foregroundColor(.grayscale100)
                    Spacer()
                    Image(name: .setting)
                }
                .padding(.horizontal,20)
                Spacer().frame(height: 30)
                HStack {
                    Image(name: .emptyImage)
                    VStack(alignment: .leading) {
                        HStack(spacing: 6) {
                            Text("작성자 닉네임")
                                .font(.pretendard(.semiBold, 16))
                                .foregroundColor(.grayscale100)
                            Image(name: .editPen)
                        }
                        HStack {
                            ForEach(0..<3){ cell in
                                Text("#매른이")
                                    .font(.pretendard(.medium, 14))
                                    .foregroundColor(.iris100)
                            }
                        }
                        HStack {
                            Image(name: .fillLike)
                            Text("00,000명에게 도움을 줬어요.")
                                .font(.pretendard(.medium, 14))
                                .foregroundColor(.grayscale70)
                        }
                    }
                    Spacer()
                }
                .padding(.horizontal,20)
                Spacer().frame(height: 20)
                Rectangle()
                    .frame(height: 14)
                    .foregroundColor(Color.grayscale10)
                HStack {
                    ForEach(Array(tabItems.enumerated()), id: \.element) { index, item in
                        VStack(spacing: 4) {
                            Text(item)
                                .font(.pretendard(.semiBold, 16))
                                .frame(maxWidth: .infinity, minHeight: 52)
                                .foregroundColor(selectedTab == index ? .grayscale100 : .grayscale100.opacity(0.3))
                            Rectangle()
                                .foregroundColor(selectedTab == index ? .red100 : .grayscale30)
                                .frame(width: 82, height: selectedTab == index ? 2 : 0)
                        }
                        .onTapGesture {
                            self.selectedTab = index
                        }
                    }
                }.zIndex(1)
                Color.grayscale30.frame(height: 1)
                    .offset(y: -1)
                VStack(spacing: 0) {
                    Spacer().frame(height: 12)
                    HStack {
                        Text("\(itemText[selectedTab]) 14개")
                            .font(.pretendard(.regular, 12))
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
                    .frame(height: 40)
                }
                .padding(.horizontal,20)
                ForEach(0..<10) { _ in
                    VStack {
//                        ReviewCell()
                    }
                    Color.grayscale30.opacity(0.5).frame(height: 1)
                        .padding(.bottom, 16)
                }
                .padding(.horizontal,10)
            }
        }
    }
}

struct MyInfoView_Previews: PreviewProvider {
    static var previews: some View {
        MyInfoView()
    }
}
