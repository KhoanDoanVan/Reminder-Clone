//
//  ReminderStatsBuilder.swift
//  CoreData-Reminders
//
//  Created by Đoàn Văn Khoan on 31/03/2024.
//

import Foundation
import SwiftUI

enum ReminderStatType {
    case today
    case all
    case scheduled
    case completed
}

struct ReminderStatsValues {
    var todayCount : Int = 0
    var scheduledCount : Int = 0
    var allCount : Int = 0
    var completedCount : Int = 0
}


struct ReminderStatsBuilder {
    func built(myListResults: FetchedResults<MyList>) -> ReminderStatsValues {
        
        let remindersArray = myListResults.map{
            $0.remindersArray
        }.reduce([], +) // initial is empty array, with plus method means plus all reminder into list empty
        
        let allCount = calculateAllCount(reminders: remindersArray)
        let completedCount = calculateCompletedCount(reminders: remindersArray)
        let scheduledCount = calculateScheduledCount(reminders: remindersArray)
        let todaysCount = calculateTodaysCount(reminders: remindersArray)
        
        return ReminderStatsValues(
            todayCount: todaysCount,
            scheduledCount: scheduledCount,
            allCount: allCount,
            completedCount: completedCount
        )
    }
    
    private func calculateAllCount(reminders : [Reminder]) -> Int {
        return reminders.reduce(0) { result, reminder in
            return !reminder.isCompleted ? result + 1 : result
        }
    }
    
    private func calculateCompletedCount(reminders : [Reminder]) -> Int {
        return reminders.reduce(0) { result, reminder in
            return reminder.isCompleted ? result + 1 : result
        }
    }
    
    private func calculateTodaysCount(reminders : [Reminder]) -> Int {
        return reminders.reduce(0) { result, reminder in
            let isToday = reminder.reminderDate?.isToday ?? false
            return isToday ? result + 1 : result
        }
    }
    
    private func calculateScheduledCount(reminders : [Reminder]) -> Int {
        return reminders.reduce(0) { result, reminder in
            return (
                (reminder.reminderDate != nil || reminder.reminderTime != nil)
                &&
                !reminder.isCompleted
            ) ? result + 1 : result
        }
    }
}
