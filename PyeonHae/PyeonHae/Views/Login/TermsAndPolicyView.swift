//
//  TermsAndPolicyView.swift
//  PyeonHae
//
//  Created by 정건호 on 2023/01/09.
//

import SwiftUI

struct TermsAndPolicyView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            HStack {
                Text("이용약관과 개인정보 처리 방침")
                    .font(.pretendard(.bold, 20))
                    .foregroundColor(.grayscale100)
                    .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 0))
                Spacer()
                Image(name: .close)
                    .padding(.trailing, 10)
                    .onTapGesture {
                        dismiss()
                    }
            }
            Spacer()
        }
    }
}
