//
//  ReminderStatsView.swift
//  CoreData-Reminders
//
//  Created by Đoàn Văn Khoan on 31/03/2024.
//

import SwiftUI

struct ReminderStatsView: View {
    
    let icon : String
    let title : String
    let count : Int?
    var iconColor : Color = .blue
    
    var body: some View {
        VStack{
            HStack{
                VStack(alignment : .leading, spacing : 10){
                    Image(systemName: icon)
                        .foregroundStyle(iconColor)
                        .font(.title)
                    Text(title)
                        .opacity(0.8)
                }
                Spacer()
                if let count {
                    Text("\(count)")
                        .font(.largeTitle)
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(.gray)
            .foregroundStyle(.white)
            .clipShape(RoundedRectangle(cornerRadius: 16.0, style: .continuous))
        }
    }
}

#Preview {
    ReminderStatsView(icon: "calendar", title: "Calendar", count: 9)
}
