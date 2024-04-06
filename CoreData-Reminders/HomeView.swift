//
//  ContentView.swift
//  CoreData-Reminders
//
//  Created by Đoàn Văn Khoan on 28/03/2024.
//

import SwiftUI

struct HomeView: View {
    
    @FetchRequest(sortDescriptors: [])
    private var myListResults : FetchedResults<MyList>
    
    @FetchRequest(sortDescriptors: [])
    private var searchResults : FetchedResults<Reminder>
    
    @FetchRequest(fetchRequest: RemindersService.getRemindersByType(statType: .today))
    private var todayResults : FetchedResults<Reminder>
    
    @FetchRequest(fetchRequest: RemindersService.getRemindersByType(statType: .all))
    private var allResults : FetchedResults<Reminder>
    
    @FetchRequest(fetchRequest: RemindersService.getRemindersByType(statType: .scheduled))
    private var scheduledResults : FetchedResults<Reminder>
    
    @FetchRequest(fetchRequest: RemindersService.getRemindersByType(statType: .completed))
    private var completedResults : FetchedResults<Reminder>
    
    @State private var isPresented : Bool = false
    @State private var search : String = ""
    @State private var searching : Bool = false
    
    private var reminderStatsBuilder = ReminderStatsBuilder()
    @State private var reminderStatsValues = ReminderStatsValues()
    
    var body: some View {
        NavigationStack{
            VStack {
                ScrollView {
                    
                    HStack{
                        NavigationLink {
                            ReminderListView(reminders: todayResults)
                        }label: {
                            ReminderStatsView(icon: "calendar", title: "Today", count: reminderStatsValues.todayCount)
                        }
                        
                        NavigationLink {
                            ReminderListView(reminders: allResults)
                        }label: {
                            ReminderStatsView(icon: "tray.circle.fill", title: "All", count: reminderStatsValues.allCount)
                        }
                    }
                    HStack{
                        NavigationLink {
                            ReminderListView(reminders: scheduledResults)
                        }label: {
                            ReminderStatsView(icon: "calendar.circle.fill", title: "Scheduled", count: reminderStatsValues.scheduledCount)
                        }
                        
                        NavigationLink {
                            ReminderListView(reminders: completedResults)
                        }label: {
                            ReminderStatsView(icon: "checkmark.circle.fill", title: "Completed", count: reminderStatsValues.completedCount)
                        }
                    }
                    
                    Text("My Lists")
                        .frame(maxWidth: .infinity, alignment : .leading)
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                    
                    MyListsView(myLists: myListResults)
                    
                    Button{
                        isPresented = true
                    }label: {
                        Text("Add List")
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .padding()
                            .font(.headline)
                    }
                }
            }
            .onAppear{
                reminderStatsValues = reminderStatsBuilder.built(myListResults: myListResults)
            }
            .onChange(of: search){ newValue, oldValue in
                searching = !search.isEmpty ? true : false
                searchResults.nsPredicate = RemindersService.getRemindersBySearchTerm(search)
                    .predicate
            }
            .overlay {
                ReminderListView(reminders: searchResults)
                    .opacity(searching ? 1.0 : 0.0)
            }
            .sheet(isPresented: $isPresented, content: {
                NavigationView{
                    AddNewListView { name, color in
                        do {
                            try RemindersService.saveMyList(name, color)
                        } catch {
                            print(error)
                        }
                    }
                }
            })
            .navigationTitle("Reminder")
            .padding()
        }
        .searchable(text: $search)
    }
}

#Preview {
    HomeView()
}
