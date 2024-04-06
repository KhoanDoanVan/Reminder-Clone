//
//  AddNewListView.swift
//  CoreData-Reminders
//
//  Created by Đoàn Văn Khoan on 28/03/2024.
//

import SwiftUI

struct AddNewListView: View {
    
    @Environment(\.dismiss) private var dismiss
    @State private var name : String = ""
    @State private var selectedColor : Color = .yellow
    
    let onSave: (String, UIColor) -> Void
    
    private var isFormValid : Bool {
        !name.isEmpty
    }
    
    var body: some View {
        VStack{
            VStack{
                Image(systemName: "line.3.horizontal.circle.fill")
                    .foregroundColor(selectedColor)
                    .font(.system(size: 100))
                TextField("List name", text: $name)
                    .multilineTextAlignment(.center)
                    .textFieldStyle(.roundedBorder)
            }
            .padding(30)
            .clipShape(RoundedRectangle(cornerRadius: 10.0))
            
            ColorPickerView(selectedColor: $selectedColor)
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .toolbar {
            ToolbarItem(placement: .principal){
                Text("New list")
                    .font(.headline)
            }
            ToolbarItem(placement: .topBarLeading){
                Button("Close"){
                    dismiss()
                }
            }
            ToolbarItem(placement: .topBarTrailing){
                Button("Done"){
                    onSave(name, UIColor(selectedColor))
                    dismiss()
                }
                .disabled(!isFormValid)
            }
        }
    }
}

#Preview {
    NavigationStack{
        AddNewListView(onSave: { (_,_) in })
    }
}
