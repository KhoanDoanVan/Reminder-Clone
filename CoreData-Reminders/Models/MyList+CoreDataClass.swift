//
//  MyList+CoreDataClass.swift
//  CoreData-Reminders
//
//  Created by Đoàn Văn Khoan on 28/03/2024.
//

import Foundation
import CoreData

@objc(MyList)
public class MyList: NSManagedObject{
    var remindersArray: [Reminder] {
        reminders?.allObjects.compactMap{
            ($0 as! Reminder)
        } ?? []
    }
}
