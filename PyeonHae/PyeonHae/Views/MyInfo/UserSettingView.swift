//
//  UserSettingView.swift
//  PyeonHae
//
//  Created by 이주화 on 2023/05/18.
//

import SwiftUI

struct UserSettingView: View {
    @State private var isOn = false
    
    var body: some View {
        VStack {
            VStack(alignment: .center, spacing: 13) {
                Spacer()
                Text("환경설정")
                    .font(.pretendard(.medium, 12))
                    .foregroundColor(.grayscale100)
                HStack {
                    Text("알림 켜기")
                        .font(.pretendard(.medium, 16))
                        .foregroundColor(.grayscale100)
                    Spacer()
                    Toggle("", isOn: $isOn)
                                    .toggleStyle(CustomToggleStyle())
                }
                Spacer()
            }
            .frame(height: 100)
            Divider().frame(height: 1)
            VStack(alignment: .leading, spacing: 13) {
                Spacer()
                Text("서비스")
                    .font(.pretendard(.medium, 12))
                    .foregroundColor(.grayscale100)
                Button(action: {
                    // add action
                }) {
                    HStack {
                        Text("공지사항")
                            .font(.pretendard(.medium, 16))
                            .foregroundColor(.grayscale100)
                        Spacer()
                        Image(name: .arrowRight)
                            .resizable()
                            .frame(width: 4.5, height: 9)
                    }
                }
                Button(action: {
                    // add action
                }) {
                    HStack {
                        Text("이벤트")
                            .font(.pretendard(.medium, 16))
                            .foregroundColor(.grayscale100)
                        Spacer()
                        Image(name: .arrowRight)
                            .resizable()
                            .frame(width: 4.5, height: 9)
                    }
                }
                Spacer()
            }
            .frame(height: 140)
            Divider().frame(height: 1)
            VStack(alignment: .leading, spacing: 13) {
                Spacer()
                Text("앱 정보")
                    .font(.pretendard(.medium, 12))
                    .foregroundColor(.grayscale100)
                Button(action: {
                    // add action
                }) {
                    HStack {
                        Text("이벤트")
                            .font(.pretendard(.medium, 16))
                            .foregroundColor(.grayscale100)
                        Spacer()
                        Image(name: .arrowRight)
                            .resizable()
                            .frame(width: 4.5, height: 9)
                    }
                }
                Text("현재 버전 0.001")
                    .font(.pretendard(.medium, 16))
                    .foregroundColor(.grayscale100)
                Spacer()
            }
            .frame(height: 140)
            Rectangle()
                .frame(height: 14)
                .foregroundColor(Color.grayscale10)
            VStack(spacing: 16) {
                Spacer()
                Button(action: {
                    // add action
                }) {
                    Text("앱 정보")
                        .font(.pretendard(.medium, 16))
                        .foregroundColor(.grayscale100)
                }
                Button(action: {
                    // add action
                }) {
                    Text("앱 정보")
                        .font(.pretendard(.medium, 16))
                        .foregroundColor(.grayscale100)
                }
                Spacer()
            }
            .frame(height: 84)
//            Rectangle()
//                .frame(height: 300)
//                .foregroundColor(Color.grayscale10)
        }
        .padding(.horizontal, 24)
    }
}

struct UserSettingView_Previews: PreviewProvider {
    static var previews: some View {
        UserSettingView()
    }
}
