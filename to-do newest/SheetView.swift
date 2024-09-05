//
//  SheetView.swift
//  to-do newest
//
//  Created by Guinter Zaffalon on 02/09/24.
//
//aqui se encontra a estrutura do botão de adicionar task
import SwiftUI

struct SheetView: View {
    
    @State var task: String = ""
    @State var description: String = ""
    
    var body: some View {
        VStack{
                Text("Qual sua tarefa?")
                    .font(.title)
                    .padding()
                
            VStack{
                TextField("Tarefa:", text: $task)
                    .background(.thinMaterial, in:.rect(cornerRadius: 12))
                    .textFieldStyle(.roundedBorder)
                    .padding()
                
                TextField("Descrição:", text: $description, axis: .vertical)
                    .background(.thinMaterial)
                    .textFieldStyle(.roundedBorder)
                    .padding()

            }
            
            
            .padding()
            
            Spacer()
        }
        .frame(maxWidth:.infinity)
        .background(Color(.systemBackground))
        .cornerRadius(20)
    }
}
