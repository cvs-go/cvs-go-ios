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
    
    func toImage(completion: @escaping (UIImage?) -> Void) {
        if let url = URL(string: self) {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard let data = data, error == nil else {
                    completion(nil)
                    return
                }
                DispatchQueue.main.async {
                    completion(UIImage(data: data))
                }
            }
            task.resume()
        } else {
            completion(nil)
        }
    }
}
