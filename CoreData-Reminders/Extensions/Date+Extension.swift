//
//  Date+Extension.swift
//  CoreData-Reminders
//
//  Created by Đoàn Văn Khoan on 30/03/2024.
//

import Foundation

extension Date {
    var isToday: Bool {
        let calendar = Calendar.current
        return calendar.isDateInToday(self)
    }
    
    var isTomorrow: Bool {
        let calendar = Calendar.current
        return calendar.isDateInTomorrow(self)
    }
    
    var dateComponent: DateComponents {
        Calendar.current.dateComponents([.year,.month,.day,.hour,.minute], from: self)
    }
}
