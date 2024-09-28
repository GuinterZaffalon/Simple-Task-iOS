import SwiftUI

struct ItemsView: View {
    @Binding var items: [TDModel]
    var saveItems: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            ForEach(items.indices, id: \.self) { item in
                HStack {
                    TaskView(items: items[item])
                        .background(alignment: .topLeading) {
                            GeometryReader { geo in
                                    Rectangle()
                                        .frame(width: 2)
                                        .frame(maxHeight: items[item].isComplete ? geo.size.height - 5 : 0)
                                        .offset(y: 23)
                                        .padding(.leading, 12)
                            }
                        }
                        .onTapGesture {
                            withAnimation(.spring(duration: 0.3)) {
                                items[item].isComplete.toggle()
                                saveItems()
                            }
                        }
                        .onLongPressGesture (minimumDuration: 0.1){
                            //agora a lógica aqui chefe!
                        }
                        .padding(.leading, 8)
                }
            }
            
            HStack {
                Image(systemName: !items.isEmpty && items.allSatisfy { $0.isComplete } ? "checkmark.circle.fill" : "circle")
                Text("Finish!")
                Spacer()
            }
            .foregroundStyle(!items.isEmpty && items.allSatisfy { $0.isComplete } ? .green : .gray)
            .font(.title2)
            .onTapGesture {
                toggleItems()
            }
        }
    }
    
    func toggleItems() {
        let allTrue = items.allSatisfy({ $0.isComplete })
        updateItemsSequentially(makeTrue: !allTrue, reverse: allTrue)
    }
    
    func updateItemsSequentially(makeTrue: Bool, reverse: Bool) {
        let delayStep = 0.3
        let indices = reverse ? Array(items.indices.reversed()) : Array(items.indices)
        for (offset, index) in indices.enumerated() {
            let delay = Double(offset) * delayStep
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                withAnimation {
                    items[index].isComplete = makeTrue
                    saveItems()
                }
            }
        }
    }
}
