//
//  ColorPickerView.swift
//  CoreData-Reminders
//
//  Created by Đoàn Văn Khoan on 28/03/2024.
//

import SwiftUI

struct ColorPickerView: View {
    
    @Binding var selectedColor : Color
    
    let colors : [Color] = [.red, .green, .blue, .yellow, .orange, .purple]
    
    var body: some View {
        HStack{
            ForEach(colors, id: \.self){ color in
                ZStack{
                    Circle().fill()
                        .foregroundColor(color)
                        .padding(2)
                    Circle()
                        .strokeBorder(selectedColor == color ? .gray : .clear, lineWidth: 4)
                        .scaleEffect(CGSize(width: 1.2, height: 1.2))
                }.onTapGesture {
                    selectedColor = color
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: 100)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    ColorPickerView(selectedColor: .constant(.red))
}
