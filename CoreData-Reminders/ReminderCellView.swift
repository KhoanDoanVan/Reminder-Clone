//
//  ReminderCellView.swift
//  CoreData-Reminders
//
//  Created by Đoàn Văn Khoan on 30/03/2024.
//

import SwiftUI

enum ReminderCellEvents {
    case onInfo
    case onCheckedChange(Reminder, Bool)
    case onSelect(Reminder)
}

struct ReminderCellView: View {
    
    let reminder : Reminder
    let delay = Delay()
    @State private var isChecked: Bool = false
    let onEvent: (ReminderCellEvents) -> Void
    let isSelected : Bool
    
    private func formatDate(_ date : Date) -> String {
        if date.isToday {
            return "Today"
        } else if date.isTomorrow {
            return "Tomorrow"
        } else {
            return date.formatted(date: .numeric, time: .omitted)
        }
    }
    
    var body: some View {
        HStack{
            Image(systemName: isChecked ? "circle.inset.filled" : "circle")
                .font(.title2)
                .opacity(0.4)
                .onTapGesture{
                    isChecked.toggle()
                    
                    // cancel the old task
                    delay.cancel()
                    
                    // call onCheckedChange inside the delay
                    delay.performWork {
                        onEvent(.onCheckedChange(reminder, isChecked))
                    }
                }
            
            VStack(alignment : .leading){
                Text(reminder.title ?? "")
                if let notes = reminder.notes, !notes.isEmpty {
                    Text(notes)
                        .opacity(0.4)
                        .font(.caption)
                }
                
                HStack{
                    if let reminderDate = reminder.reminderDate {
                        Text(formatDate(reminderDate))
                    }
                    
                    if let reminderTime = reminder.reminderTime {
                        Text(reminderTime.formatted(date: .omitted, time: .shortened))
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.caption)
                .opacity(0.4)
            }
            
            Spacer()
            
            Image(systemName: "info.circle.fill")
                .opacity(isSelected ? 1.0 : 0.0)
                .onTapGesture {
                    onEvent(.onInfo)
                }
        }
        .onAppear{
            isChecked = reminder.isCompleted
        }
        .contentShape(Rectangle())
        .onTapGesture {
            onEvent(.onSelect(reminder))
        }
    }
}

#Preview {
    ReminderCellView(reminder: PreviewData.reminder, onEvent: { _ in }, isSelected: false)
}
