//
//  SelectListView.swift
//  CoreData-Reminders
//
//  Created by Đoàn Văn Khoan on 30/03/2024.
//

import SwiftUI

struct SelectListView: View {
    
    @FetchRequest(sortDescriptors: [])
    private var myListFetchResults : FetchedResults<MyList>
    @Binding var selectedList: MyList?
    
    var body: some View {
        List(myListFetchResults){ list in
            HStack {
                HStack{
                    Image(systemName: "line.3.horizontal.circle.fill")
                        .foregroundStyle(Color(list.color))
                    Text(list.name)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .contentShape(Rectangle())
                .onTapGesture {
                    self.selectedList = list
                }
                
                Spacer()
                
                if selectedList == list {
                    Image(systemName: "checkmark")
                }
            }
        }
    }
}

#Preview {
    SelectListView(selectedList: .constant(PreviewData.myList))
        .environment(\.managedObjectContext, CoreDataProvider.shared.persistentContainer.viewContext)
}
