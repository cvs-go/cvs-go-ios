//
//  RegexConstants.swift
//  PyeonHae
//
//  Created by 정건호 on 2022/12/31.
//

import Foundation

extension Constants {
    enum Regex {
        static let email = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        static let password = "^(?=.*[A-Za-z])(?=.*[0-9])(?=.*[!@#$%^&*()_+=-]).{10,20}"
    }
}
