//
//  TiemLineView.swift
//  to-do newest
//
//  Created by Guinter Zaffalon on 02/09/24.
//
import SwiftUI

struct TDModel: Identifiable, Codable {
    var id = UUID()
    var title: String;
    var details: String;
    var isComplete: Bool;
}

struct TimeLineView: View {
    @AppStorage ("ItemsKey") private var storedItemsData: Data = Data()
    @State private var isSheetPresented: Bool = false
    @State var items: [TDModel] = []
    
    var body: some View {
        ScrollView {
            
            Text("Simple Task")
                .font(.title)
            
            if items.isEmpty {
                Text("Nenhuma tarefa por aqui! \n que tal começar criando uma?")
                    .font(.title2)
                    .foregroundColor(.gray)
            } else {
                ItemsView(items: $items, saveItems: saveItems)
            }
                
            
            HStack{
                Image(systemName: "pencil")
                    .frame(width: 52, height: 52)
                    .background(.thinMaterial,in: Circle())
                    .offset(x: 5, y: -5)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                    .onTapGesture {
                        isSheetPresented = true
                    }
            }
            .sheet(isPresented: $isSheetPresented) {
                SheetView(items: $items)
                    .presentationDetents([.medium])
                .presentationDragIndicator(.visible)        }
            
            .safeAreaPadding()
        }
    }
    func saveItems() {
            if let encoded = try? JSONEncoder().encode(items) {
                storedItemsData = encoded
            }
        }
        
    func loadItems() {
        if let decoded = try? JSONDecoder().decode([TDModel].self, from: storedItemsData) {
            items = decoded
        }
    }
}

#Preview{
    TimeLineView()
}
