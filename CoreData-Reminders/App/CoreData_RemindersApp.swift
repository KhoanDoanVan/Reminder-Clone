//
//  CoreData_RemindersApp.swift
//  CoreData-Reminders
//
//  Created by Đoàn Văn Khoan on 28/03/2024.
//

import SwiftUI
import UserNotifications

@main
struct CoreData_RemindersApp: App {
    
    init(){
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound,.badge]){ granted, error in
            if granted {
                
            } else {
                
            }
        }
    }
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(\.managedObjectContext, CoreDataProvider.shared.persistentContainer.viewContext)
        }
    }
}
