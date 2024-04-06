//
//  PreviewData.swift
//  CoreData-Reminders
//
//  Created by Đoàn Văn Khoan on 30/03/2024.
//

import Foundation
import CoreData


class PreviewData{
    
    static var reminder : Reminder {
        let viewContext = CoreDataProvider.shared.persistentContainer.viewContext
        let request = Reminder.fetchRequest()
        return (try? viewContext.fetch(request).first) ?? Reminder()
    }
    
    static var myList : MyList {
        let viewContext = CoreDataProvider.shared.persistentContainer.viewContext
        let request = MyList.fetchRequest()
        return (try? viewContext.fetch(request).first) ?? MyList()
    }
}
