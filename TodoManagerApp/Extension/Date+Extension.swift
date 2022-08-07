//
//  Date+Extension.swift
//  TodoManagerApp
//
//  Created by DevApp on 2022/04/27.
//

import Foundation

//TaskTodayviewで使用する今日分の日付範囲を限定するメソッド。
extension Date {
    static var today: Date {
        let calendar = Calendar(identifier: .gregorian)
        let time = Date()
        let today = calendar.startOfDay(for: time)
        return today
    }
    
    static var tomorrow: Date {
        let calendar = Calendar(identifier: .gregorian)
        let tomorrow = calendar.date(byAdding: DateComponents(day: 1), to: Date.today)!
        return tomorrow
    }
}
