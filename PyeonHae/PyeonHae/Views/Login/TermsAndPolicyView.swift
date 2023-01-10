//
//  TermsAndPolicyView.swift
//  PyeonHae
//
//  Created by 정건호 on 2023/01/09.
//

import SwiftUI

struct TermsAndPolicyView: View {
    @Environment(\.dismiss) var dismiss
    @State var showTermsOfUse = false
    @State var showPrivacyAndPolicy = false
    var body: some View {
        HStack {
            Text("이용약관과 개인정보 처리 방침")
                .font(.pretendard(.bold, 20))
                .foregroundColor(.grayscale100)
                .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 0))
            Spacer()
            Image(name: .close)
                .padding(.trailing, 18)
                .onTapGesture {
                    dismiss()
                }
        }
        ScrollView {
            VStack {
                Spacer().frame(height: 29)
                VStack {
                    HStack {
                        Spacer().frame(width: 24)
                        Text("이용약관 보기")
                        Spacer()
                        Image(name: .arrowDown)
                        Spacer().frame(width: 24)
                    }
                    .onTapGesture {
                        withAnimation {
                            showTermsOfUse.toggle()
                        }
                    }
                    Spacer().frame(height: 17)
                    if showTermsOfUse {
                        Text("텍스트 내용이 들어갑니다.텍스트 내용이 들어갑니다.텍스트 내용이 들어갑니다.텍스트 내용이 들어갑니다.텍스트 내용이 들어갑니다.텍스트 내용이 들어갑니다.텍스트 내용이 들어갑니다.텍스트 내용이 들어갑니다.텍스트 내용이 들어갑니다.텍스트 내용이 들어갑니다.텍스트 내용이 들어갑니다.텍스트 내용이 들어갑니다.텍스트 내용이 들어갑니다.텍스트 내용이 들어갑니다.텍스트 내용이 들어갑니다.텍스트 내용이 들어갑니다.텍스트 내용이 들어갑니다.텍스트 내용이 들어갑니다.텍스트 내용이 들어갑니다.텍스트 내용이 들어갑니다.텍스트 내용이 들어갑니다.텍스트 내용이 들어갑니다.텍스트 내용이 들어갑니다.텍스트 내용이 들어갑니다.텍스트 내용이 들어갑니다.텍스트 내용이 들어갑니다.텍스트 내용이 들어갑니다.텍스트 내용이 들어갑니다.텍스트 내용이 들어갑니다.텍스트 내용이 들어갑니다.텍스트 내용이 들어갑니다.텍스트 내용이 들어갑니다.텍스트 내용이 들어갑니다.텍스트 내용이 들어갑니다.텍스트 내용이 들어갑니다.텍스트 내용이 들어갑니다.텍스트 내용이 들어갑니다.텍스트 내용이 들어갑니다.텍스트 내용이 들어갑니다.텍스트 내용이 들어갑니다.텍스트 내용이 들어갑니다.텍스트 내용이 들어갑니다.텍스트 내용이 들어갑니다.")
                    }
                    Color.mineGray100.frame(maxWidth: .infinity, maxHeight: 1)
                    Spacer().frame(height: 19)
                    HStack {
                        Spacer().frame(width: 24)
                        Text("개인정보 처리 방침 보기")
                        Spacer()
                        Image(name: showPrivacyAndPolicy ? .arrowUp : .arrowDown)
                        Spacer().frame(width: 24)
                    }
                    .onTapGesture {
                        withAnimation {
                            showPrivacyAndPolicy.toggle()
                        }
                    }
                    Spacer().frame(height: 17)
                    if showPrivacyAndPolicy {
                        Text("텍스트 내용이 들어갑니다.텍스트 내용이 들어갑니다.텍스트 내용이 들어갑니다.텍스트 내용이 들어갑니다.텍스트 내용이 들어갑니다.텍스트 내용이 들어갑니다.텍스트 내용이 들어갑니다.텍스트 내용이 들어갑니다.텍스트 내용이 들어갑니다.텍스트 내용이 들어갑니다.텍스트 내용이 들어갑니다.텍스트 내용이 들어갑니다.텍스트 내용이 들어갑니다.텍스트 내용이 들어갑니다.텍스트 내용이 들어갑니다.텍스트 내용이 들어갑니다.텍스트 내용이 들어갑니다.텍스트 내용이 들어갑니다.텍스트 내용이 들어갑니다.텍스트 내용이 들어갑니다.텍스트 내용이 들어갑니다.텍스트 내용이 들어갑니다.텍스트 내용이 들어갑니다.텍스트 내용이 들어갑니다.텍스트 내용이 들어갑니다.텍스트 내용이 들어갑니다.텍스트 내용이 들어갑니다.텍스트 내용이 들어갑니다.텍스트 내용이 들어갑니다.텍스트 내용이 들어갑니다.텍스트 내용이 들어갑니다.텍스트 내용이 들어갑니다.텍스트 내용이 들어갑니다.텍스트 내용이 들어갑니다.텍스트 내용이 들어갑니다.텍스트 내용이 들어갑니다.텍스트 내용이 들어갑니다.텍스트 내용이 들어갑니다.텍스트 내용이 들어갑니다.텍스트 내용이 들어갑니다.텍스트 내용이 들어갑니다.텍스트 내용이 들어갑니다.텍스트 내용이 들어갑니다.")
                    }
                    Spacer()
                }
            }
        }
    }
}
