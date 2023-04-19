//
//  FiltersModel.swift
//  PyeonHae
//
//  Created by 정건호 on 2023/03/26.
//

import Foundation

struct FiltersModel: Codable {
    let timestamp: String
    let data: FiltersDataModel
}

struct FiltersDataModel: Codable {
    let convenienceStores: [ConvenienceStoresModel]
    let categories: [CategoryModel]
    let eventTypes: [EventTypeModel]
    let highestPrice: Int
}

struct ConvenienceStoresModel: Codable {
    let id: Int
    let name: String
}

struct CategoryModel: Codable {
    let id: Int
    let name: String
}

struct EventTypeModel: Codable {
    let value: String
    let name: String
}
