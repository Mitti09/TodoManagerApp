//
//  EditTaskView.swift
//  TodoManagerApp
//
//  Created by DevApp on 2022/02/22.
//

import SwiftUI

struct EditTaskView: View {
    @State var newTask: String = ""
    @Environment(\.managedObjectContext) var viewContext
    
    fileprivate func addNewTask() {
        Item.create(in: self.viewContext, name: self.newTask)
        self.newTask = ""
    }
    
    fileprivate func CancelTask() {
        self.newTask = ""
    }
    
    fileprivate func CheckTask() {
        if newTask.isEmpty == false {
            addNewTask()
        }
    }
    
    var body: some View {
        HStack {
            TextField("タスクを入力してください", text: $newTask, onCommit: {
                self.addNewTask()
            })
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Button(action: {
                self.CheckTask()
            }) {
                Text("追加")
            }
            Button(action: {
                self.CancelTask()
            }) {
                Text("Cancel")
                    .foregroundColor(.red)
            }
        }
    }
}

struct EditTaskView_Previews: PreviewProvider {
    static var previews: some View {
        EditTaskView()
    }
}

