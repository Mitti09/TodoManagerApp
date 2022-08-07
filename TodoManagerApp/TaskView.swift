//
//  TaskView.swift
//  TodoManagerApp
//
//  Created by DevApp on 2022/02/22.
//

import SwiftUI

struct TaskView<Label>: View where Label: View {
    @Binding var checkstatus: Bool
    @Environment(\.managedObjectContext) var viewContext
    
    private var label: ()-> Label
    
    public init(checkstatus: Binding<Bool>, @ViewBuilder label:
              @escaping ()-> Label)
    {
        self._checkstatus = checkstatus
        self.label = label
    }
    
    var body: some View {
        HStack {
            Image(systemName: checkstatus ?
                "circlebadge.fill": "circlebadge")
                .onTapGesture {
                    self.checkstatus.toggle()
                }
            label()
        }
    }
}

struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            TaskView(checkstatus: .constant(false)) {
                Text("牛乳を買う")
            }
        }
    }
}

