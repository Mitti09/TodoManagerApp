//
//  ContentView.swift
//  TodoManagerApp
//
//  Created by DevApp on 2022/02/22.
//

import SwiftUI
import CoreData

struct ContentView: View {

    
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.time, ascending: false)],
        animation: .default)
    
    var items: FetchedResults<Item>

    //calendarviewから参照する日付。
    @State var didselectDate = Date()
    @State var today = Date()
    @State var tommorow = Date()
    @State var dayString:String = ""

    var body: some View {

            VStack {
                CalendarView(didselectDate: $didselectDate, today: $today, tommorow: $tommorow, dayString: $dayString)
                    .frame(height: 300)
                
                Text("\(dayString)のタスク")
                       .frame(maxWidth: .infinity, alignment: .leading)
                       .padding()
                
                SelectedDayTaskView(items: FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Item.time, ascending: true)], predicate: NSPredicate(format: "time BETWEEN {%@ , %@}", today as NSDate, tommorow as NSDate)))
                TaskTodayView()
            }
            .padding()
    }
    
}
    
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let persistenceController = PersistenceController.shared.managedObjectContext
        
        ContentView()
            .environment(\.managedObjectContext, persistenceController)
    }
}
