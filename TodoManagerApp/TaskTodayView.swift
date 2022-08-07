//
//  TaskTodayView.swift
//  TodoManagerApp
//
//  Created by DevApp on 2022/04/27.
//

import SwiftUI

struct TaskTodayView: View {
    
    @State var isShowAllTaskView = false
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.time, ascending: true)], predicate: NSPredicate(format: "time BETWEEN {%@ , %@}", Date.today as NSDate, Date.tomorrow as NSDate), animation: .default)
    
    var todoList: FetchedResults<Item>
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            VStack(alignment: .leading, spacing: 0) {
                Text("今日のタスク").font(.footnote).bold()
                    .padding()
                List(todoList) { todo in
                    TodoListView(todo: todo)
                }
            }
            Button(action: {
                //画面遷移する処理
                isShowAllTaskView = true
            }, label: {
                Image(systemName: "tray.full.fill")
                    .font(.largeTitle)
                    .foregroundColor(Color.gray)
                    .padding(40)
            })
                .sheet(isPresented: $isShowAllTaskView) {
                    AllTaskView()
                }
        }
    }
}

struct TaskTodayView_Previews: PreviewProvider {
    static var previews: some View {
        let persistenceController = PersistenceController.shared.managedObjectContext
        
        TaskTodayView()
            .environment(\.managedObjectContext, persistenceController)
    }
}
