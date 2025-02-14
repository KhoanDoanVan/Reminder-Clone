//
//  ReminderEditConfig.swift
//  CoreData-Reminders
//
//  Created by Đoàn Văn Khoan on 30/03/2024.
//

import Foundation


struct ReminderEditConfig{
    var title : String = ""
    var notes : String?
    var isCompleted : Bool = false
    var hasDate : Bool = false
    var hasTime : Bool = false
    var reminderDate : Date?
    var reminderTime : Date?
    
    init(){}
    
    init(reminder: Reminder){
        title = reminder.title ?? ""
        notes = reminder.notes
        isCompleted = reminder.isCompleted
        reminderDate = reminder.reminderDate
        reminderTime = reminder.reminderTime
        hasDate = reminder.reminderDate != nil
        hasTime = reminder.reminderTime != nil
    }
}
