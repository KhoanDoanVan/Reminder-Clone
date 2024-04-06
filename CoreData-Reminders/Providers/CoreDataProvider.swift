//
//  CoreDataProvider.swift
//  CoreData-Reminders
//
//  Created by Đoàn Văn Khoan on 28/03/2024.
//

import Foundation
import CoreData

class CoreDataProvider{
    static let shared = CoreDataProvider()
    let persistentContainer : NSPersistentContainer
    
    private init(){
        
        // registered transformer
        ValueTransformer.setValueTransformer(UIColorTransformer(), forName: NSValueTransformerName("UIColor"))
        
        persistentContainer = NSPersistentContainer(name: "RemindersModel")
        persistentContainer.loadPersistentStores{ description, error in
            if let error {
                fatalError("Error initalizing RemindersModel \(error)")
            }
        }
    }
}
