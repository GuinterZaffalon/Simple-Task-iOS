//
//  SheetViewModel.swift
//  to-do newest
//
//  Created by Guinter Zaffalon on 02/09/24.
//
//aqui está o model do botao de adicionar task
import SwiftUI

class SheetViewModel: ObservableObject {
    @Published var isSheetPresented = false
    
    func showSheet() {
        isSheetPresented = true
    }
    
    func hideSheet() {
        isSheetPresented = false
    }
}
