import SwiftUI

struct MyListDetailView: View {
    
    let myList : MyList
    @State private var openAddReminder: Bool = false
    @State private var title: String = ""
    
    @FetchRequest(sortDescriptors: [])
    private var reminderResults : FetchedResults<Reminder>
    
    private var isFormValid: Bool {
        !title.isEmpty
    }
    
    init(myList : MyList){
        self.myList = myList
        _reminderResults = FetchRequest(fetchRequest: RemindersService.getRemindersByList(myList: myList))
    }
    
    var body: some View {
        VStack{
            ReminderListView(reminders: reminderResults)
        
            HStack{
                Image(systemName: "plus.circle.fill")
                Button(action: {
                    openAddReminder.toggle()
                }) {
                    Text("New Reminder")
                }
            }
            .foregroundColor(.blue)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
        }
        .sheet(isPresented: $openAddReminder, content: {
            VStack {
                TextField("Enter a title", text: $title)
                    .padding()
                
                HStack {
                    Button("Cancel") {
                        openAddReminder.toggle()
                        title = "" // Clear the title
                    }
                    
                    Button("Done") {
                        do {
                            try RemindersService.saveReminderToMyList(myList: myList, reminderTitle: title)
                            openAddReminder.toggle()
                            title = "" // Clear the title
                        } catch {
                            print(error.localizedDescription)
                        }
                    }
                    .disabled(!isFormValid)
                }
            }
        })
    }
}


