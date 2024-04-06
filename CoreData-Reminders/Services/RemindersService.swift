//
//  RemindersService.swift
//  CoreData-Reminders
//
//  Created by Đoàn Văn Khoan on 28/03/2024.
//

import Foundation
import CoreData
import UIKit

class RemindersService{
    static var viewContext: NSManagedObjectContext {
        CoreDataProvider.shared.persistentContainer.viewContext
    }
    
    static func save() throws {
        try viewContext.save()
    }
    
    // insert list
    static func saveMyList(_ name : String, _ color : UIColor) throws {
        let myList = MyList(context: viewContext)
        myList.name = name
        myList.color = color
        try save()
    }
    
    // update reminder
    static func updateReminder(reminder: Reminder, editConfig: ReminderEditConfig) throws -> Bool{
        let reminderToUpdate = reminder
        reminderToUpdate.isCompleted = editConfig.isCompleted
        reminderToUpdate.title = editConfig.title
        reminderToUpdate.notes = editConfig.notes
        reminderToUpdate.reminderDate = editConfig.hasDate ? editConfig.reminderDate : nil
        reminderToUpdate.reminderTime = editConfig.hasTime ? editConfig.reminderTime : nil
        
        try save()
        return true
    }
    
    static func deleteReminder(_ reminder : Reminder) throws {
        viewContext.delete(reminder)
        try save()
    }
    
    // insert reminder
    static func saveReminderToMyList(myList: MyList, reminderTitle: String) throws {
        let reminder = Reminder(context: viewContext)
        reminder.title = reminderTitle
        myList.addToReminders(reminder)
        try save()
    }
    
    static func getRemindersByList(myList : MyList) -> NSFetchRequest<Reminder> {
        let request = Reminder.fetchRequest()
        request.sortDescriptors = [] // ORDER BY
        request.predicate = NSPredicate(format: "list = %@ AND isCompleted = false", myList) // WHERE
        return request
    }
    
    static func getRemindersByType(statType: ReminderStatType) -> NSFetchRequest<Reminder> {
        let request = Reminder.fetchRequest()
        request.sortDescriptors = []
        
        switch statType {
        case .all :
            request.predicate = NSPredicate(format: "isCompleted = false")
        case .today:
            let today = Date() // March 31, 2024, 3:15 PM
            let startOfDay = Calendar.current.startOfDay(for: today) // March 31, 2024, 12:00 AM
            let endOfDay = Calendar.current.date(byAdding: .day, value: 1, to: startOfDay)
            request.predicate = NSPredicate(format: "(reminderDate >= %@) AND (reminderDate < %@)", startOfDay as NSDate, endOfDay! as NSDate)
        case .scheduled :
            request.predicate = NSPredicate(format: "(reminderDate != nil OR reminderTime != nil) AND isCompleted = false")
        case .completed :
            request.predicate = NSPredicate(format: "isCompleted = true")
        }
        
        return request
    }
    
    static func getRemindersBySearchTerm(_ search : String) -> NSFetchRequest<Reminder>{
        let request = Reminder.fetchRequest()
        request.sortDescriptors = []
        request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", search)
        return request
    }
}
