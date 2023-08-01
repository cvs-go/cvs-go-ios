//
//  UserSettingView.swift
//  PyeonHae
//
//  Created by 이주화 on 2023/05/18.
//

import SwiftUI

struct UserSettingView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var isOn = false
    
    var body: some View {
        VStack {
            settingTopBar
            VStack(alignment: .leading, spacing: 0) {
                titleView("서비스")
                contentsView("공지사항")
            }
            divider(height: 1)
            VStack(alignment: .leading, spacing: 0) {
                titleView("앱 정보")
                contentsView("오픈 라이센스")
                contentsView("현재 버전 0.00.1", arrowHidden: true)
            }
            divider(height: 14)
            contentsView("로그아웃", color: .grayscale50, arrowHidden: true)
            contentsView("회원탈퇴", color: .grayscale50, arrowHidden: true)
            Spacer()
        }
    }
    
    var settingTopBar: some View {
        HStack(spacing: 0) {
            Spacer().frame(width: 14)
            Image(name: .arrowLeft)
                .onTapGesture {
                    self.presentationMode.wrappedValue.dismiss()
                }
            Spacer().frame(width: 9)
            Text("설정")
                .font(.pretendard(.bold, 18))
                .foregroundColor(.black)
            Spacer()
        }
        .frame(height: 44)
    }
    
    @ViewBuilder
    func titleView(_ text: String) -> some View {
        Text(text)
            .font(.pretendard(.medium, 12))
            .foregroundColor(.mineGray400)
            .frame(height: 28)
            .padding(.horizontal, 24)
    }
    
    @ViewBuilder
    func contentsView(
        _ text: String,
        color: Color = .mineGray900,
        arrowHidden: Bool = false
    ) -> some View {
        Button(action: {
            // add action
        }) {
            HStack {
                Text(text)
                    .font(.pretendard(.medium, 16))
                    .foregroundColor(color)
                Spacer()
                Image(name: .arrowRight)
                    .hidden(arrowHidden)
            }
        }
        .padding(.horizontal, 24)
        .frame(height: 40)
    }
    
    func divider(height: CGFloat) -> some View {
        Rectangle().foregroundColor(.grayscale20).frame(height: height)
    }
}

struct UserSettingView_Previews: PreviewProvider {
    static var previews: some View {
        UserSettingView()
    }
}
