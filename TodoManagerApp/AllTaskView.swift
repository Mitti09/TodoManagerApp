//
//  AllTaskView.swift
//  TodoManagerApp
//
//  Created by DevApp on 2022/04/28.
//

import SwiftUI
import CoreData

struct AllTaskView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.time, ascending: false)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    @State var addNewTask = false

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(items) { todo in
                        NavigationLink(destination: TaskEditingView(todo: todo)) {
                            
                            TodoListView(todo: todo)
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
                EditTaskView()
            } 
            .navigationTitle("タスク一覧")
            .navigationBarItems(trailing: Button(action: {
                //シート表示をする。
                self.addNewTask = true
            }) {
                Text("新規作成")
            })
            .sheet(isPresented: $addNewTask) {
                ChangeTaskView()
                    .environment(\.managedObjectContext, self.viewContext)
            }
            
            
        }
        
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            viewContext.perform {
                offsets.map { items[$0] }.forEach(viewContext.delete)
                
                do {
                    try viewContext.save()
                } catch {
                    // Replace this implementation with code to handle the error appropriately.
                    // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    let nsError = error as NSError
                    fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                }
            }
        }
    }
}
    
struct AllTaskView_Previews: PreviewProvider {
    static var previews: some View {
        let persistenceController = PersistenceController.shared.managedObjectContext
        
        AllTaskView()
            .environment(\.managedObjectContext, persistenceController)
    }
}
