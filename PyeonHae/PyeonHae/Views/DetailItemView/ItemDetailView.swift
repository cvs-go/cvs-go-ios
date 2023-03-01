//
//  ItemDetailView.swift
//  PyeonHae
//
//  Created by 이주화 on 2023/03/01.
//

import SwiftUI

struct ItemDetailView: View {
    @State var isBookMark: Bool = false
    @State var isHeartMark: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.grayscale20, lineWidth: 1)
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.grayscale10)
                Image(name: .sampleImage)
                    .resizable()
                    .frame(width: 200, height: 200)
            }
            .frame(height: 200)
            Text("롯데푸드")
                .font(.pretendard(.regular, 12))
                .foregroundColor(.grayscale70)
                .padding(.top, 12)
            HStack {
                Text("백두마운틴바")
                    .font(.pretendard(.semiBold, 18))
                    .foregroundColor(.grayscale100)
                Spacer()
                Button(action: {
                    isHeartMark.toggle()
                }){
                    isHeartMark ? Image(name: .heartMarkFill) :
                    Image(name: .heartMark)
                }
                .frame(width: 18, height: 18)
                Button(action: {
                    isBookMark.toggle()
                }){
                    isBookMark ? Image(name: .bookMarkFill) : Image(name: .bookMark)
                }
                .frame(width: 18, height: 18)
            }
            Text("1,000원")
                .font(.pretendard(.medium, 18))
                .foregroundColor(.grayscale85)
            HStack(spacing: 4) {
                Image(name: .logoCU)
                Image(name: .logoGS)
                Image(name: .logoMini)
                Image(name: .logoEmart)
                Image(name: .logoSeven)
            }
            .padding(.top, 16)
            HStack {
                Text("이 제품을 주로 찾는 유저예요.")
                    .font(.pretendard(.regular, 12))
                    .foregroundColor(.grayscale70)
                    .padding(.trailing, 15)
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                    HStack {
                        Text("맵찔이 11")
                            .font(.pretendard(.regular, 12))
                            .foregroundColor(.grayscale85)
                        Spacer()
                        Text("초코킬러 9")
                            .font(.pretendard(.regular, 12))
                            .foregroundColor(.grayscale85)
                        Spacer()
                        Text("소식가 6")
                            .font(.pretendard(.regular, 12))
                            .foregroundColor(.grayscale85)
                    }
                    .padding(.vertical, 4)
                    .padding(.horizontal, 8)
                }
                .foregroundColor(Color.grayscale20)
            }
            .padding(.top, 26)
        }
        .padding(.top, 21)
        .padding(.horizontal, 20)
    }
}

struct ItemDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ItemDetailView()
    }
}
