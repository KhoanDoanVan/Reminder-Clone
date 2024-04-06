//
//  Delay.swift
//  CoreData-Reminders
//
//  Created by Đoàn Văn Khoan on 31/03/2024.
//

import Foundation

class Delay {
    private var seconds: Double
    var workItem : DispatchWorkItem?
    
    init(seconds: Double = 2.0) {
        self.seconds = seconds
    }
    
    func performWork(_ work : @escaping () -> Void) {
        workItem = DispatchWorkItem(block: {
            work()
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: workItem!)
    }
    
    func cancel(){
        workItem?.cancel()
    }
}
