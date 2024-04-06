//
//  ReminderListView.swift
//  CoreData-Reminders
//
//  Created by Đoàn Văn Khoan on 30/03/2024.
//

import SwiftUI

struct ReminderListView: View {
    
    let reminders : FetchedResults<Reminder>
    @State private var selectedReminder: Reminder?
    @State private var showReminderDetail: Bool = false
    
    private func reminderCheckedChanged(reminder : Reminder, isCompleted : Bool){
        var editConfig = ReminderEditConfig(reminder: reminder)
        editConfig.isCompleted = isCompleted
        
        do {
            let _ = try RemindersService.updateReminder(reminder: reminder, editConfig: editConfig)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func isReminderSelected(_ reminder : Reminder) -> Bool {
        selectedReminder?.objectID == reminder.objectID
    }
    
    var body: some View {
        VStack{
            List{
                ForEach(reminders){ reminder in
                    ReminderCellView(
                        reminder: reminder,
                        onEvent :
                            { event in
                                switch event {
                                    case .onSelect(let reminder):
                                        selectedReminder = reminder
                                    case .onCheckedChange(let reminder, let isCompleted):
                                        reminderCheckedChanged(reminder: reminder, isCompleted : isCompleted)
                                    case .onInfo:
                                        showReminderDetail.toggle()
                                }
                            },
                        isSelected: isReminderSelected(reminder))
                }
                .onDelete(perform: { indexSet in
                    indexSet.forEach { index in
                        let reminder = reminders[index]
                        
                        do{
                            try RemindersService.deleteReminder(reminder)
                        } catch {
                            print(error)
                        }
                    }
                })
            }
        }
        .sheet(isPresented: $showReminderDetail, content: {
            ReminderDetailView(reminder: Binding($selectedReminder)! )
        })
    }
}

struct ReminderListView_Previews: PreviewProvider {
    struct ReminderListViewContainer : View {
        
        @FetchRequest(sortDescriptors: [])
        private var reminderResults: FetchedResults<Reminder>
        
        var body: some View {
            ReminderListView(reminders: reminderResults)
        }
    }
    
    static var previews: some View{
        ReminderListViewContainer()
            .environment(\.managedObjectContext, CoreDataProvider.shared.persistentContainer.viewContext)
    }
}
