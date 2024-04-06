//
//  CustomOperators.swift
//  CoreData-Reminders
//
//  Created by Đoàn Văn Khoan on 30/03/2024.
//

import Foundation
import SwiftUI

public func ??<T>(lsh: Binding<Optional<T>>, rhs: T) -> Binding<T> {
    Binding(
        get: {
            lsh.wrappedValue ?? rhs
        }, set: {
            lsh.wrappedValue = $0
        }
    )
}
