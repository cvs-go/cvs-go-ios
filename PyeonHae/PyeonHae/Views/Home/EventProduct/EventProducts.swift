//
//  EventProducts.swift
//  PyeonHae
//
//  Created by 정건호 on 2023/01/23.
//

import SwiftUI

struct EventProducts: View {
    @ObservedObject var searchViewModel: SearchViewModel
    @Binding var eventProducts: [Product]
    @Binding var selectedProduct: Product?
    @Binding var showEventProducts: Bool
    @Binding var showEventDetail: Bool
    
    var body: some View {
        VStack {
            Button(action: { showEventProducts = true }) {
                HStack {
                    Spacer().frame(width: 20)
                    Text("행사 상품")
                        .font(.pretendard(.bold, 18))
                        .foregroundColor(.grayscale100)
                    Spacer()
                    Image(name: .arrowRight)
                    Spacer().frame(width: 16)
                }
            }
            Spacer().frame(height: 16)
            ScrollView(.horizontal) {
                HStack {
                    ForEach($eventProducts, id: \.self) { eventProduct in
                        EventProductCell(eventProduct: eventProduct)
                            .onTapGesture {
                                searchViewModel.requestReview(productID: eventProduct.productId.wrappedValue)
                                searchViewModel.requestProductDetail(productID: eventProduct.productId.wrappedValue)
                                self.selectedProduct = eventProduct.wrappedValue
                                self.showEventDetail = true
                            }
                    }
                }
                .padding(.horizontal, 20)
            }
        }
        .background(Color.white)
    }
}
