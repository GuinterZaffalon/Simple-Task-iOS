//
//  SheetView.swift
//  to-do newest
//
//  Created by Guinter Zaffalon on 02/09/24.
//
//aqui se encontra a estrutura do botão de adicionar task
import SwiftUI

struct SheetView: View {
    @Binding var items: [TDModel]
    @Environment(\.dismiss) var dismiss;
    
    @State private var newTitle: String = ""
    @State private var newDetails: String = ""
    @State private var newIsComplete: Bool = false
    
    var body: some View {
        VStack{
                Text("Qual sua tarefa?")
                    .font(.title)
                    .padding()
                    .ignoresSafeArea()
                
            VStack{
                TextField("Tarefa:", text: $newTitle)
                    .background(.thinMaterial, in:.rect(cornerRadius: 12))
                    .textFieldStyle(.roundedBorder)
                    .padding()
                
                TextField("Descrição:", text: $newDetails, axis: .vertical)
                    .background(.thinMaterial)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                
                Button("Adicionar") {
                    addItem()
                    dismiss()
                }
                .padding()
                .buttonStyle(.bordered)
            }
            
            
            .padding()
            
            Spacer()
        }
        .frame(maxWidth:.infinity)
        .background(Color(.systemBackground))
        .cornerRadius(20)
    }
    
    private func addItem() {
        let newItem = TDModel(title: newTitle, details: newDetails, isComplete: newIsComplete)
        if (!newTitle.isEmpty) {
            items.append(newItem)
        }
    }
}


