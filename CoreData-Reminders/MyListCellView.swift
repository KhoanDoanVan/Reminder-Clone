//
//  MyListCellView.swift
//  CoreData-Reminders
//
//  Created by Đoàn Văn Khoan on 30/03/2024.
//

import SwiftUI

struct MyListCellView: View {
    let myList : MyList
    var body: some View {
        HStack{
            Image(systemName: "line.3.horizontal.circle.fill")
                .foregroundStyle(Color(myList.color))
            Text(myList.name)
            Spacer()
            Image(systemName: "chevron.forward")
                .foregroundStyle(.gray)
                .opacity(0.5)
                .padding([.trailing], 10)
        }
    }
}

#Preview {
    MyListCellView(myList: PreviewData.myList)
}
