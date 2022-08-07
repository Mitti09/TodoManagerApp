//
//  Item+Extenison.swift
//  TodoManagerApp
//
//  Created by DevApp on 2022/02/22.
//

import SwiftUI
import CoreData

extension Item {

    //coredataの保存処理
    static func create(in managedObjectContext: NSManagedObjectContext,
                          name: String,
                          time: Date? = Date()){
           let todo = self.init(context: managedObjectContext)
           print(name)
           todo.time = time
           todo.name = name
           todo.id = UUID().uuidString

           do {
               try  managedObjectContext.save()
           } catch {
               let nserror = error as NSError
               fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
           }
       }
    
    static func create1(in managedObjectContext: NSManagedObjectContext,
                        widgetname: String,
                        timestamp: Date? = Date()){
         let todo = self.init(context: managedObjectContext)
         print(widgetname)
         todo.timestamp = timestamp
         todo.widgetname = widgetname
         todo.id = UUID().uuidString

         do {
             try  managedObjectContext.save()
         } catch {
             let nserror = error as NSError
             fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
         }
     }
    
    //タスクのステータスを管理する変数。
    enum State: Int16 {
        case todo
        case done
    }
}

    //widgetに表示する曜日、日付を用意する変数。
class DateModel {
    var dayString: String = ""
    var dayNember: String = ""

    init() {
        self.dayString = "曜日"
        self.dayNember = "何日"
        let dt = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "EEE", options: 0, locale: Locale(identifier: "ja_JP"))
        print(dateFormatter.string(from: dt))
        dayString = dateFormatter.string(from: dt)

        dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "dd", options: 0, locale: Locale(identifier: "ja_JP"))
        print(dateFormatter.string(from: dt))
        dayNember = dateFormatter.string(from: dt)
    }


}

