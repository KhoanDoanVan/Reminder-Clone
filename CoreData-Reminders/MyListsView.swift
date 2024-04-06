//
//  MyListsView.swift
//  CoreData-Reminders
//
//  Created by Đoàn Văn Khoan on 30/03/2024.
//

import SwiftUI

struct MyListsView: View {
    
    let myLists : FetchedResults<MyList>
    
    var body: some View {
        NavigationStack{
            if myLists.isEmpty {
                Spacer()
                Text("No reminders found")
            } else {
                ForEach(myLists){ item in
                    NavigationLink(value: item) {
                        VStack{
                            MyListCellView(myList: item)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding([.leading], 10)
                                .font(.title3)
                            Divider()
                        }
                    }
                }
                .scrollContentBackground(.hidden)
                .navigationDestination(for: MyList.self){ item in
                    MyListDetailView(myList: item)
                        .navigationTitle(item.name)
                }
            }
        }
    }
}

