//
//  EditLetter.swift
//  PyeonHae
//
//  Created by 이주화 on 2023/02/09.
//

import SwiftUI

struct EditLetterView: View {
    @State var title: String = ""
    @State var text: String = ""
    
    var body: some View {
        VStack {
            TextField("ㅇㅇㄹㄴ", text: $title)
                .padding(.horizontal, 20)
                .padding(.top, 12)
            Divider()
            TextField("리뷰는 100자 이상 부터 등록 가능하며, 리뷰를 5개 이상 등록하면 정회원으로 승급됩니다. 정회원이 되시면 모든 리뷰를 감상하실 수 있습니다.", text: $text)
                .padding(.horizontal, 20)
                .padding(.bottom, 100)
            Divider()
            
        }
        .background(Color.white)
    }
}

struct EditLetterView_Previews: PreviewProvider {
    static var previews: some View {
        EditLetterView()
    }
}
