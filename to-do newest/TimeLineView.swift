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
    @AppStorage("ItemsKey") private var storedItemsData: Data = Data()
    @State private var isSheetPresented: Bool = false
    @State var items: [TDModel] = []

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Simple Task")
                    .font(.title)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding()
            }
            .background(Color(.systemGray6))


            ScrollView {
                
                VStack{
                    if items.isEmpty {
                        Text("Nenhuma tarefa por aqui! \n Que tal começar criando uma?")
                            .font(.title2)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding()
                    } else {
                        ItemsView(items: $items, saveItems: saveItems)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            }
            .padding()

            HStack {
                Image(systemName: "pencil")
                    .frame(width: 52, height: 52)
                    .background(.thinMaterial, in: Circle())
                    .onTapGesture {
                        isSheetPresented = true
                    }
            }
            .sheet(isPresented: $isSheetPresented) {
                SheetView(items: $items)
                    .presentationDetents([.medium])
                    .presentationDragIndicator(.visible)
            }
            .padding()
        }
        .frame(maxHeight: .infinity)
        .safeAreaInset(edge: .top) {
            Color.clear
                .frame(height: 0)
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
