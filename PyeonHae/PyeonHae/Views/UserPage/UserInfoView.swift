//
//  UserInfoView.swift
//  PyeonHae
//
//  Created by 이주화 on 2023/02/08.
//

import SwiftUI

struct UserInfoView: View {
    @State var followCheck: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                Image(name: .emptyImage)
                VStack(alignment: .leading) {
                    Text("작성자 닉네임")
                        .font(.pretendard(.semiBold, 16))
                        .foregroundColor(.grayscale100)
                    HStack {
                        ForEach(0..<3){ cell in
                            Text("#매른이")
                                .font(.pretendard(.medium, 14))
                                .foregroundColor(.iris100)
                        }
                    }
                    HStack {
                        Image(name: .statistics)
                        Text("나와 취향이 66% 비슷해요.")
                            .font(.pretendard(.medium, 14))
                            .foregroundColor(.grayscale70)
                    }
                }
                Spacer()
            }
            Button(action: {
                followCheck.toggle()
            }) {
                if(!followCheck) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                        Text("팔로우")
                            .font(.pretendard(.bold, 18))
                            .foregroundColor(.white)
                    }
                    .foregroundColor(Color.grayscale50)
                } else {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                        Text("팔로우")
                            .font(.pretendard(.bold, 18))
                            .foregroundColor(.white)
                    }
                    .foregroundColor(Color.red100)
                }
            }
        }
        .padding(.all, 20)
        .background(Color.white)
        .frame(height: 175)
    }
}

struct UserInfoView_Previews: PreviewProvider {
    static var previews: some View {
        UserInfoView()
    }
}
