//
//  StringExtension.swift
//  PyeonHae
//
//  Created by 정건호 on 2022/12/31.
//

import UIKit

extension String {
    func isValidEmail() -> Bool {
        let email = NSPredicate(format: "SELF MATCHES %@", Constants.Regex.email)
        return email.evaluate(with: self)
    }
    
    func isValidPassword() -> Bool {
        let password = NSPredicate(format: "SELF MATCHES %@", Constants.Regex.password)
        return password.evaluate(with: self)
    }
    
    func toImage() -> UIImage? {
        if let url = URL(string: self) {
            do {
                let data = try Data(contentsOf: url)
                return UIImage(data: data)
            } catch(let error) {
                print(error)
            }
        }
        return nil
    }
}
