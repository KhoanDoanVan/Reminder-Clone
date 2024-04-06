//
//  NotificationManager.swift
//  CoreData-Reminders
//
//  Created by Đoàn Văn Khoan on 03/04/2024.
//

import Foundation
import UserNotifications

struct UserData {
    let title : String?
    let body : String?
    let date : Date?
    let time : Date?
}

class NotificationManager {
    static func scheduleNotifications(userData : UserData){
        let content = UNMutableNotificationContent()
        content.title = userData.title ?? ""
        content.body = userData.body ?? ""
        
        var dateComponents = Calendar.current.dateComponents([.year,.month,.day,.hour,.minute], from: userData.date ?? Date())
        
        if let reminderTime = userData.time {
            let reminderTimeDateComponents = reminderTime.dateComponent
            dateComponents.hour = reminderTimeDateComponents.hour
            dateComponents.minute = reminderTimeDateComponents.minute
        }
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let request = UNNotificationRequest(identifier: "Reminder Notification", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
}
