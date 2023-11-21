//
//  EventProductCell.swift
//  PyeonHae
//
//  Created by 정건호 on 2023/01/21.
//

import SwiftUI
import Kingfisher

struct EventProductCell: View {
    @Binding var eventProduct: Product
    
    var body: some View {
        VStack(alignment: .leading) {
            if let url = eventProduct.productImageUrl, let imageUrl = URL(string: url) {
                KFImage(imageUrl)
                    .resizable()
                    .frame(width: 106, height: 106)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.borderColor)
                    )
            }
            Spacer().frame(height: 8)
            Text(eventProduct.productName)
                .font(.pretendard(.regular, 14))
                .foregroundColor(.grayscale85)
            Spacer().frame(height: 2)
            Text("\(eventProduct.productPrice)원")
                .font(.pretendard(.semiBold, 18))
                .foregroundColor(.grayscale100)
            Spacer().frame(height: 8)
            HStack(spacing: 2) {
                if eventProduct.convenienceStoreEvents.contains(where: { $0.eventType == "BOGO" }) {
                    Image(name: .logoOnePlusOne)
                }
                if eventProduct.convenienceStoreEvents.contains(where: { $0.eventType == "BTGO" }) {
                    Image(name: .logoTwoPlusOne)
                }
                if eventProduct.convenienceStoreEvents.contains(where: { $0.eventType == "GIFT" }) {
                    Image(name: .logoGift)
                }
                if eventProduct.convenienceStoreEvents.contains(where: { $0.eventType == "DISCOUNT" }) {
                    Image(name: .logoDiscount)
                }
            }
            Spacer().frame(height: 24)
        }
    }
}
