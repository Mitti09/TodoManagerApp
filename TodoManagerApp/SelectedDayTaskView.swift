//
//  SelectedDayTaskView.swift
//  TodoManagerApp
//
//  Created by DevApp on 2022/06/14.
//

import SwiftUI
import CoreData

struct SelectedDayTaskView: View {
    
    @State var didselectDate = Date()
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest var items: FetchedResults<Item>


    var body: some View {
        VStack {
            List {
                ForEach(items) { item in
                    VStack {
                        Text(item.name!)
                    }
                }
            }
            
        }
    }
}


//プレビューでは全タスクの一覧を表示するfetchrequestを作成。

struct SelectedDayTaskView_Previews: PreviewProvider {
    static var previews: some View {
        
        let persistenceController = PersistenceController.shared.managedObjectContext

        
        SelectedDayTaskView(items: FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Item.time, ascending: true)]))
            .environment(\.managedObjectContext, persistenceController)
    }
}
