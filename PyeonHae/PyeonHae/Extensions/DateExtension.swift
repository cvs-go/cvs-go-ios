//
//  DateExtension.swift
//  PyeonHae
//
//  Created by 정건호 on 2023/07/16.
//

import Foundation

extension Date {
    func currentTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        dateFormatter.timeZone = NSTimeZone(name: "ko_KR") as TimeZone?
        
        return dateFormatter.string(from: self)
    }
    
    func currentDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yy.MM.dd"
        dateFormatter.timeZone = NSTimeZone(name: "ko_KR") as TimeZone?
        
        return dateFormatter.string(from: self)
    }
}
