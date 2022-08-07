//
//  TaskEditingView.swift
//  TodoManagerApp
//
//  Created by DevApp on 2022/04/22.
//

import SwiftUI

struct TaskEditingView: View {
    @ObservedObject var todo: Item
    @Environment(\.managedObjectContext) var viewContext
    @State var showingSheet = false
    
    fileprivate func save() {
        do {
            try self.viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    fileprivate func delete() {
        viewContext.delete(todo)
        save()
    }
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
//        NavigationView {
            Form {
                Section(header: Text("タスク")) {
                    TextField("タスクを入力してください", text: Binding($todo.name, "new task"))
                }
                Section(header: Toggle(isOn: Binding(isNotNil: $todo.time, defaultValue: Date())) { Text("時間を指定する")}) {
                    if todo.time != nil {
                        DatePicker(selection: Binding($todo.time, Date()), label: { Text("日時") })
                    } else {
                        Text("時間未設定")
                    }
                }
                
                Section(header: Text("操作")) {
                    Button(action: {
                        self.showingSheet = true
                    }) {
                        HStack(alignment: .center) {
                            Image(systemName: "minus.circle.fill")
                            Text("削除")
                }
                    }.foregroundColor(.red)
                }
            }.navigationTitle("タスクの編集")
                .navigationBarItems(trailing: Button(action: {
                        self.save()
                        self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("閉じる")
                })
                .actionSheet(isPresented: $showingSheet) {
                    ActionSheet(title: Text("タスクの削除"), message: Text("このタスクを削除します。よろしいですか。"), buttons: [.destructive(Text("削除")) {
                        self.delete()
                        self.presentationMode.wrappedValue.dismiss()
                    },
                    .cancel(Text("キャンセル"))
                ])
            //}
        }
    }
}

struct TaskEditingView_Previews: PreviewProvider {
    static var previews: some View {
        let persistenceController = PersistenceController.shared.managedObjectContext
        
        let newTodo = Item(context: persistenceController)
        newTodo.name = "掃除"
        
        return
            TaskEditingView(todo: newTodo)
    }
}
