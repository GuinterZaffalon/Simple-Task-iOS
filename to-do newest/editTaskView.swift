//
//  editTaskView.swift
//  Simple_Task
//
//  Created by Guinter Zaffalon on 28/09/24.
//

import SwiftUI

struct EditTaskView: View {
    @Binding var item: TDModel
    @Binding var isEditing: Bool
    @State private var title: String = ""
    @State private var details: String = ""
    @Binding var isSheetPresentedEdit: Bool
    
    var body: some View {
        NavigationView{
            Form{
                Section(header: Text("Qual a alteração?")){
                    TextField("Título", text: $title)
                    TextField("Detalhes", text: $details)
                }
            }
            .navigationBarTitle("Editar tarefa", displayMode: .inline)
            .navigationBarItems(
                leading: Button("Cancelar"){
                    isEditing = false
                    isSheetPresentedEdit = false
                },
                trailing: Button("Salvar") {
                    SaveTask()
                }
            )
            .onAppear{
                title = item.title
                details = item.details
            }
        }
    }
    
    func SaveTask() {
        item.title = title
        item.details = details
        isEditing = false
        isSheetPresentedEdit = false
    }
}
