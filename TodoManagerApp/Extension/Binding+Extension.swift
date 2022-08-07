//
//  Binding+Extension.swift
//  TodoManagerApp
//
//  Created by DevApp on 2022/04/20.
//

import Foundation
import SwiftUI

extension Binding {
    
    //日付を未設定にする際のメソッド。
    init<T>(isNotNil source: Binding<T?>, defaultValue: T) where Value == Bool {
        self.init(get: { source.wrappedValue != nil },
                  set: { source.wrappedValue = $0 ? defaultValue : nil })
    }
    
    init(_ source: Binding<Value?>, _ defaultValue: Value) {
        self.init(get:{
            if source.wrappedValue == nil {
                source.wrappedValue = defaultValue
            }
            return source.wrappedValue ?? defaultValue
        },set:{
            source.wrappedValue = $0
        })
    }
    
}
