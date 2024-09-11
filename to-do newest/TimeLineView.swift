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
            
            VStack(spacing:20){
                ForEach(items.indices, id: \.self) { item in
                    HStack{
                        TaskView(items: items[item])
                            .background(alignment: .topLeading) {
                                GeometryReader{geo in
                                    Rectangle()
                                        .frame(width: 2)
                                        .frame(maxHeight:items[item].isComplete ? geo.size.height - 5 : 0)
                                        .offset(y: 23)
                                        .padding(.leading,12)
                                }
                                
                            }
                            .onTapGesture{
                                withAnimation(.spring(duration: 0.3)) {
                                    items[item].isComplete.toggle()
                                }
                            }
                        .padding(.leading, 8)
                    }
                }
                HStack{
                    Image(systemName:!items.isEmpty && items.allSatisfy { $0.isComplete
                    } ? "checkmark.circle.fill" : "circle")
                    Text("Finish!")
                    Spacer()
                }
                .foregroundStyle(!items.isEmpty && items.allSatisfy{$0.isComplete} ? .green : .gray)
                .font(.title2)
                .onTapGesture {
                    toggleItems()
                }
            }
            .onAppear(perform: loadItems)
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
    
    private func saveItems() {
        if let encoded = try? JSONEncoder().encode(items) {
            storedItemsData = encoded
        }
    }
    
    private func loadItems() {
        if let decoded = try? JSONDecoder().decode([TDModel].self, from: storedItemsData) {
            items = decoded
        }
    }
    
    func toggleItems(){
        let alltrue = items.allSatisfy({$0.isComplete})
        updateItemsSequentially(makeTrue: !alltrue, reverse: alltrue)
        saveItems()
    }
    
    func updateItemsSequentially(makeTrue: Bool, reverse: Bool) {
        let delayStep = 0.3
        let indices = reverse ? Array(items.indices.reversed()) : Array(items.indices)
        for (offset, index) in indices.enumerated() {
            let delay = Double(offset) * delayStep
            DispatchQueue.main.asyncAfter(deadline: .now() + delay){
                withAnimation {
                    items[index].isComplete = makeTrue
                    saveItems()
                }
            }
        }
        
    }
}

#Preview{
    TimeLineView()
}
