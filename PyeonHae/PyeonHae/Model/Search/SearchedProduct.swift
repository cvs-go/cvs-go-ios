//
//  SearchedProduct.swift
//  PyeonHae
//
//  Created by 정건호 on 2023/07/16.
//

import Foundation

struct SearchedProduct: Codable, Hashable {
    let timestamp: String
    let productId: Int
    let productImageUrl: String
}
