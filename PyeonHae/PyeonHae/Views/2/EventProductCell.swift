//
//  EventProductCell.swift
//  PyeonHae
//
//  Created by 정건호 on 2023/01/21.
//

import SwiftUI

struct EventProductCell: View {
    var body: some View {
        VStack(alignment: .leading) {
            ZStack {
                Image(name: .logoCU)
                    .zIndex(1)
                    .offset(x: -37, y: -37)
                Image(name: .sampleImage)
                    .resizable()
            }
            .frame(width: 106, height: 106)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.borderColor)
                )
            Spacer().frame(height: 8)
            Text("토레타P 900ml")
                .font(.pretendard(.regular, 14))
                .foregroundColor(.grayscale85)
            Spacer().frame(height: 2)
            Text("2,600원")
                .font(.pretendard(.semiBold, 18))
                .foregroundColor(.grayscale100)
            Spacer().frame(height: 8)
            Image(name: .logoOnePlusOne)
            Spacer()
        }
    }
}

struct EventProductCell_Previews: PreviewProvider {
    static var previews: some View {
        EventProductCell()
    }
}
