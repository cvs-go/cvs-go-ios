//
//  ArrayExtension.swift
//  PyeonHae
//
//  Created by 정건호 on 2023/02/18.
//

import Foundation

extension Array {
    subscript (safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
    
    func toParameter() -> String {
        return self.map { String(describing: $0) }.joined(separator: ",")
    }
}
