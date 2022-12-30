//
//  StringExtension.swift
//  PyeonHae
//
//  Created by 정건호 on 2022/12/31.
//

import Foundation

extension String {
    func isValidEmail() -> Bool {
        let email = NSPredicate(format: "SELF MATCHES %@", Constants.Regex.email)
        return email.evaluate(with: self)
    }
    
    func isValidPassword() -> Bool {
        let password = NSPredicate(format: "SELF MATCHES %@", Constants.Regex.password)
        return password.evaluate(with: self)
    }
}
