//
//  TodoListView.swift
//  TodoManagerApp
//
//  Created by DevApp on 2022/02/22.
//

import SwiftUI
import CoreData

struct TodoListView: View {
    @ObservedObject var todo: Item
    
    var body: some View {
        HStack {
            TaskView(checkstatus: Binding(get: {
                self.todo.state ==
                    Item.State.done.rawValue
            }, set: {
                self.todo.state = $0 ? Item.State.done.rawValue : Item.State.todo.rawValue
            })) {
                Text(self.todo.name ?? "")
            }
        }
    }
}

struct TodoListView_Previews: PreviewProvider {
    static var previews: some View {
        
        let persistenceController = PersistenceController.shared.managedObjectContext
        
        let newTodo = Item(context: persistenceController)
        
        newTodo.name = "掃除"
        newTodo.state = Item.State.done.rawValue
        
        return TodoListView(todo: newTodo)
    }
}

