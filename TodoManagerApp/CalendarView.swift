//
//  CalendarView.swift
//  TodoManagerApp
//
//  Created by DevApp on 2022/04/28.
//

import SwiftUI
import FSCalendar
import CoreData
import Foundation

struct CalendarView: UIViewRepresentable {
    @Binding var didselectDate: Date
    
    @Binding var today: Date
    @Binding var tommorow: Date
    
    //viewに選択された日を格納する変数
    @Binding var dayString: String
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.time, ascending: false)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    
   func makeUIView(context: Context) -> UIView {
       
       typealias UIViewType = FSCalendar
       
       let fsCalendar = FSCalendar()
       fsCalendar.scope = .month
       fsCalendar.scrollDirection = .horizontal
       fsCalendar.delegate = context.coordinator
       fsCalendar.dataSource = context.coordinator
       
       return fsCalendar
   }
    
    func makeCoordinator() -> Coordinator{
        return Coordinator(self)
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
    }
    
    class Coordinator: NSObject, FSCalendarDelegate, FSCalendarDataSource {
        
        var parent: CalendarView
        init(_ parent: CalendarView) {
            self.parent = parent

        }
        
        
        
        //5.3
        func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
            parent.didselectDate = date
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "yyyy/MM/dd", options: 0, locale: Locale(identifier: "ja_JP"))

            parent.dayString = dateFormatter.string(from: date)
            
            parent.today = date
            
            let calendar = Calendar(identifier: .gregorian)
            
            let thatDaytommrow = calendar.date(byAdding: DateComponents(day: 1), to: date)!
            
            parent.tommorow = thatDaytommrow
        }
    }
}



struct CalendarView_Previews: PreviewProvider {
    static let birthDate: Date = {
            let df = DateFormatter()
            df.dateFormat = "MM/dd/yyyy"
            df.locale = Locale(identifier: "en_us_POSIX")
        //df.timeZone = TimeZone(identifier: "UTC")
        return df.date(from: "4/4/2020")!
    }()
    
    
    static var previews: some View {
        VStack {
            CalendarView(didselectDate: .constant(birthDate), today: .constant(birthDate), tommorow: .constant(birthDate), dayString: .constant("yyyy/MM/dd"))
                .frame(height: 400)
        }
    }
}
