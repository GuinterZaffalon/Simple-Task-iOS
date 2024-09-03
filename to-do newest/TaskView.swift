//
//  TaskView.swift
//  to-do newest
//
//  Created by Guinter Zaffalon on 02/09/24.
//

import SwiftUI

struct TaskView: View {
    var items: TDModel
    var body: some View{
        HStack{
            Image(systemName: items.isComplete ? "checkmarck.circle.fill" : "circle")
                .foregroundStyle(items.isComplete ? .green : .gray)
                .frame(maxHeight: .infinity, alignment: .top)
                .font(.title2)
            VStack(alignment: .leading){
                HStack{
                    Text(items.title).font(.title2)
                        .strikethrough(items.isComplete)
                    Spacer()
                }
                Text(items.details)
                    .font(.callout)
                    .foregroundStyle(.secondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .background(.thinMaterial, in:.rect(cornerRadius: 12))
            .animation(.none, value: items.isComplete)
            Spacer()
        }
    }
}


