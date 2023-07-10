//
//  UserShared.swift
//  PyeonHae
//
//  Created by 정건호 on 2023/03/25.
//

import Foundation

@propertyWrapper
struct UserDefault<T> {
    let key: String
    let defaultValue: T
    
    var wrappedValue: T {
        get {
            return UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
}

@propertyWrapper
struct StructUserDefault<T: Codable> {
    let key: String
    let defaultValue: T
    
    var wrappedValue: T {
        get {
            if let data = UserDefaults.standard.data(forKey: key),
               let value = try? JSONDecoder().decode(T.self, from: data) {
                return value
            }
            return defaultValue
        }
        set {
            if let data = try? JSONEncoder().encode(newValue) {
                UserDefaults.standard.set(data, forKey: key)
            }
        }
    }
}

enum UserShared {
    // 로그인 되어있는 상태인지 아닌지 판별
    @UserDefault(key: "isLoggedIn", defaultValue: false)
    static var isLoggedIn: Bool
    
    @UserDefault(key: "accessToken", defaultValue: String())
    static var accessToken: String
    
    @UserDefault(key: "refreshToken", defaultValue: String())
    static var refreshToken: String
    
    @StructUserDefault(key: "tags", defaultValue: [])
    static var tags: [TagModel]
    
    @StructUserDefault(key: "filterData", defaultValue: nil)
    static var filterData: FiltersDataModel?
}
