//
//  TiemLineView.swift
//  to-do newest
//
//  Created by Guinter Zaffalon on 02/09/24.
//
import SwiftUI

struct TDModel: Identifiable {
    var id = UUID()
    var title: String;
    var details: String;
    var isComplete: Bool;
}

struct TimeLineView: View {
    @StateObject private var viewModel = SheetViewModel()
    @State var items: [TDModel] = []
    var body: some View {
        ScrollView {
            
            Text("Simple Task")
                .font(.title)
            
            VStack(spacing:20){
                ForEach(items.indices, id: \.self) { item in
                    TaskView(items: items[item])
                        .background(alignment: .topLeading, content: {
                            GeometryReader{geo in
                                Rectangle()
                                    .frame(width: 2)
                                    .frame(maxHeight:items[item].isComplete ? geo.size.height - 5 : 0)
                                    .offset(y: 23)
                                    .padding(.leading,12)
                            }
                        })
                        .onTapGesture{
                            withAnimation(.spring(duration: 0.3)) {
                                items[item].isComplete.toggle()
                            }
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
        }
        HStack{
            Image(systemName: "pencil")
                .frame(width: 52, height: 52)
                .background(.thinMaterial,in: Circle())
                .offset(x: 5, y: -5)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                .onTapGesture {
                    viewModel.showSheet()
                }
        }
        .sheet(isPresented: $viewModel.isSheetPresented) {
                    SheetView(items: $items)
                        .presentationDetents([.medium])
                        .presentationDragIndicator(.visible)        }
        
        .safeAreaPadding()
    }
    func toggleItems(){
        let alltrue = items.allSatisfy({$0.isComplete})
        updateItemsSequentially(makeTrue: !alltrue, reverse: alltrue)
    }
    func updateItemsSequentially(makeTrue: Bool, reverse: Bool) {
        let delayStep = 0.3
        let indices = reverse ? Array(items.indices.reversed()) : Array(items.indices)
        for (offset, index) in indices.enumerated() {
            let delay = Double(offset) * delayStep
            DispatchQueue.main.asyncAfter(deadline: .now() + delay){
                withAnimation {
                    items[index].isComplete = makeTrue
                }
            }
        }
        
    }
}

#Preview{
    TimeLineView()
}
