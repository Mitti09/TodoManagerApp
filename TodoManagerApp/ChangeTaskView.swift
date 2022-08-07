//
//  ChangeTask.swift
//  TodoManagerApp
//
//  Created by DevApp on 2022/04/20.
//

import SwiftUI

struct ChangeTaskView: View {
    @State var task: String = ""
    @State var time: Date? = Date()
    @Environment(\.managedObjectContext) var viewContext
    
    fileprivate func save() {
        do {
            try self.viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("タスク")) {
                    TextField("タスクを入力してください", text: $task)
                }
                Section(header: Toggle(isOn: Binding(isNotNil: $time, defaultValue: Date())) { Text("時間を指定する")}) {
                    if time != nil {
                        DatePicker(selection: Binding($time, Date()), label: { Text("日時") })
                    } else {
                        Text("時間未設定")
                    }
                }
                
                Section(header: Text("操作")) {
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        HStack(alignment: .center) {
                            Image(systemName: "minus.circle.fill")
                            Text("キャンセル")
                }
                    }.foregroundColor(.red)
                }
            }.navigationTitle("タスクの追加")
                .navigationBarItems(trailing: Button(action: {
                    if self.task.isEmpty == false {
                        Item.create(in: self.viewContext, name: self.task)
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }) {
                    Text("保存")
                })
        }
    }
}

struct ChangeTaskView_Previews: PreviewProvider {
    static var previews: some View {
        ChangeTaskView()
    }
}
