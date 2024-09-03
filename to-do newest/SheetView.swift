//
//  SheetView.swift
//  to-do newest
//
//  Created by Guinter Zaffalon on 02/09/24.
//
//aqui se encontra a estrutura do botão de adicionar task
import SwiftUI

struct SheetView: View {
    
    var body: some View {
        VStack{
            HStack{
                Text("Qual sua tarefa?")
                    .font(.title)
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
