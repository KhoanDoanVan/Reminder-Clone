//
//  ReminderDetailView.swift
//  CoreData-Reminders
//
//  Created by Đoàn Văn Khoan on 30/03/2024.
//

import SwiftUI

struct ReminderDetailView: View {
    
    @Environment(\.dismiss) private var dismiss
    @Binding var reminder: Reminder
    @State var editConfig : ReminderEditConfig = ReminderEditConfig()
    
    private var isFormValid : Bool {
        !editConfig.title.isEmpty
    }
        
    var body: some View {
        NavigationStack{
            VStack{
                List {
                    Section {
                        TextField("Title", text: $editConfig.title)
                        TextField("Notes", text: $editConfig.notes ?? "")
                    }
                    
                    Section {
                        Toggle(isOn: $editConfig.hasDate){
                            Image(systemName: "calendar")
                                .foregroundStyle(.red)
                        }
                        
                        if editConfig.hasDate {
                            DatePicker("Select Date", selection: $editConfig.reminderDate ?? Date(), displayedComponents: .date)
                        }
                        
                        Toggle(isOn: $editConfig.hasTime){
                            Image(systemName: "clock")
                                .foregroundStyle(.blue)
                        }
                        
                        if editConfig.hasDate {
                            DatePicker("Select Time", selection: $editConfig.reminderTime ?? Date(), displayedComponents: .hourAndMinute)
                        }
                        
                        Section {
                            NavigationLink{
                                SelectListView(selectedList: $reminder.list)
                            }label: {
                                HStack{
                                    Text("List")
                                    Spacer()
                                    Text(reminder.list!.name)
                                }
                            }
                        }
                    }
                    .onChange(of: editConfig.hasDate){ newValue, oldValue in
                        if oldValue {
                            editConfig.reminderDate = Date()
                        }
                    }
                    .onChange(of: editConfig.hasTime){ newValue, oldValue in
                        if oldValue {
                            editConfig.reminderTime = Date()
                        }
                    }
                }
                .listStyle(.grouped)
            }
            .onAppear{
                editConfig = ReminderEditConfig(reminder: reminder)
            }
            .navigationTitle("Details")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        do{
                            let updated = try RemindersService.updateReminder(reminder: reminder, editConfig: editConfig)
                            if updated {
                                if reminder.reminderDate != nil || reminder.reminderTime != nil {
                                    let userData = UserData(title: reminder.title, body: reminder.notes, date: reminder.reminderDate, time: reminder.reminderTime)
                                    NotificationManager.scheduleNotifications(userData: userData)
                                }
                            }
                        } catch {
                            print(error)
                        }
                        dismiss()
                    }label: {
                        Text("Done")
                    }
                    .disabled(!isFormValid)
                }
                ToolbarItem(placement : .topBarLeading) {
                    Button {
                        dismiss()
                    }label: {
                        Text("Cancel")
                    }
                }
            }
        }
    }
}

#Preview {
    ReminderDetailView(reminder: .constant(PreviewData.reminder))
}
