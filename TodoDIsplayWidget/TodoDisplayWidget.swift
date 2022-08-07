//
//  TodoDIsplayWidget.swift
//  TodoDIsplayWidget
//
//  Created by DevApp on 2022/02/22.
//

import WidgetKit
import SwiftUI
import CoreData



struct Provider: TimelineProvider {
    
    var moc = PersistenceController.shared.managedObjectContext

    init(context: NSManagedObjectContext) {
        self.moc = context
    }

    func placeholder(in context: Context) -> SimpleEntry {
        var task:[Item]?
        let request = NSFetchRequest<Item>(entityName: "Item")

        request.sortDescriptors = [NSSortDescriptor(keyPath: \Item.time, ascending: false)]


        do{
            let result = try moc.fetch(request)
            task = result

        }
        catch let error as NSError {
            print("Could not fetch.\(error.userInfo)")
        }
        return SimpleEntry(date: Date(), task: task!)
    }


    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        var task:[Item]?
        let request = NSFetchRequest<Item>(entityName: "Item")

        request.sortDescriptors = [NSSortDescriptor(keyPath: \Item.timestamp, ascending: false)]

        do{
            let result = try moc.fetch(request)
            task = result

        }
        catch let error as NSError{
            print("Could not fetch.\(error.userInfo)")
        }
        let entry = SimpleEntry(date: Date(), task: task!)
        completion(entry)
    }


    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {

        var task:[Item]?
        let request = NSFetchRequest<Item>(entityName: "Item")

        //widgetに表示するタスクのrequest処理。
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Item.timestamp, ascending: false)]
        
        //predicateによる抽出条件。
        request.predicate = NSPredicate(format: "time BETWEEN {%@ , %@}", Date.today as NSDate, Date.tomorrow as NSDate)
        
        

        do{
            let result = try moc.fetch(request)
            task = result

        }
        catch let error as NSError{
            print("Could not fetch.\(error.userInfo)")
        }


        let currentDate = Date()
        let today = DateFormatter()
        today.dateFormat = DateFormatter.dateFormat(fromTemplate: "EEE", options: 0, locale: Locale.current)
        
        
        let entries = [
            SimpleEntry(date: currentDate, task: task!),
        ]
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}


struct SimpleEntry: TimelineEntry {
    let date: Date

    let task:[Item]
}



struct TodoDisplayWidgetEntryView : View {

    var entry: Provider.Entry
    
    //widgetの左部分に表示する曜日、日付のモデル。
    var displayDate = DateModel()

    var body: some View {
        HStack {
            VStack {
                Text(displayDate.dayString)
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .foregroundColor(.gray)
                    .frame(alignment: .leading)

                Text(displayDate.dayNember)
                    .font(.title)
                    .fontWeight(.medium)
                    .frame(alignment: .leading)
                    .foregroundColor(.gray)
                
            }
            .frame(width: 120, height: 100, alignment: .center)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.black, lineWidth: 4)
            )
            
            VStack {
                Text("今日のタスク")
                ForEach(entry.task) { todo in
                    HStack {
                        Image(systemName: "poweron")
                            .frame(width: 1, height: 10, alignment: .leading)
                        Text(todo.name ?? "")
                            .frame(width: 100, height: 15, alignment: .leading)
                            .foregroundColor(.gray)
                        
                    }
                    .frame(width: .infinity, height: 10, alignment: .leading)
                }
                
            }
            .padding()
        }
    }
}

@main
struct TodoDisplayWidget: Widget {
    let kind: String = "TodoDIsplayWidget"
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider(context: PersistenceController.shared.managedObjectContext)) { entry in
            TodoDisplayWidgetEntryView(entry: entry)
                .environment(\.managedObjectContext, PersistenceController.shared.managedObjectContext)//
        }
        .supportedFamilies([.systemMedium])
        .configurationDisplayName("タスクの詳細")
        .description("タスクの詳細を確認することができます。")
    }
}
