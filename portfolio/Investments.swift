import SwiftUI
import Charts

struct Stocks: Identifiable {
    let name: String
    let price: Float
    
    var id: String { name }
}

struct Investments: View {
    @State
    private var price: [Stocks] = [
        .init(name: "Bitcoin", price: 1700),
        .init(name: "Ethereum", price: 2000),
        .init(name: "Solana", price: 1000)
    ]
    
    @State private var isEditingStock: Bool = false
    @State private var isAddingStock: Bool = false
    @State private var selectedStock: Stocks?
    @State private var editedStockName: String = ""
    @State private var editedStockPrice: String = ""
    @State private var newStockName: String = ""
    @State private var newStockPrice: String = ""
    @State private var errorMessage: String?
    
    private var mostSold: String {
        price.max(by: { $0.price < $1.price })?.name ?? "N/A"
    }
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    isAddingStock = true
                }) {
                    Image(systemName: "plus")
                        .font(.title)
                        .padding(8)
                }
                .buttonStyle(PlainButtonStyle())
                .foregroundColor(.primary)
            }
            
            // Chart with legend disabled
            Chart(price, id: \.name) { element in
                SectorMark(
                    angle: .value("Sales", element.price),
                    innerRadius: .ratio(0.618),
                    angularInset: 1.5
                )
                .cornerRadius(5)
                .foregroundStyle(by: .value("Name", element.name))
            }
            .padding(.all)
            .chartLegend(.hidden) // Disable default chart legend
            .chartBackground { chartProxy in
                GeometryReader { geometry in
                    let frame = geometry[chartProxy.plotFrame!]
                    VStack {
                        Text("Most Representative")
                            .font(.callout)
                            .foregroundStyle(.secondary)
                        Text(mostSold)
                            .font(.title2.bold())
                            .foregroundColor(.primary)
                    }
                    .position(x: frame.midX, y: frame.midY)
                }
            }
            
            // Custom Legend with Context Menu
            HStack {
                ForEach(price) { stock in
                    Button(action: {
                        selectedStock = stock
                        editedStockName = stock.name
                        editedStockPrice = "\(stock.price)"
                        isEditingStock = true
                    }) {
                        HStack {
                            Circle()
                                .fill(colorForStock(stock.name))
                                .frame(width: 10, height: 10)
                            Text(stock.name)
                                .font(.system(size: 14))
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                    .padding(.horizontal, 8)
                    .contextMenu { // Add a context menu
                        Button(role: .destructive) {
                            deleteStock(stock)
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
                }
            }
            .padding(.top, 8)
            
            Spacer()
        }
        // Sheet for editing stock
        .sheet(isPresented: $isEditingStock) {
            editStockSheet()
        }
        // Sheet for adding stock
        .sheet(isPresented: $isAddingStock) {
            addStockSheet()
        }
    }
    
    // Sheet for editing stock
    private func editStockSheet() -> some View {
        VStack {
            Text("Edit Stock")
                .font(.headline)
            
            Form {
                TextField("Stock Name", text: $editedStockName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .submitLabel(.done)
                    .onSubmit {
                        updateStock()
                    }
                
                TextField("Stock Price", text: $editedStockPrice)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .submitLabel(.done)
                    .onSubmit {
                        updateStock()
                    }
                
                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .font(.caption)
                }
            }
            .padding()
            
            HStack {
                Button("Cancel") {
                    isEditingStock = false
                    resetInputs()
                }
                .padding()
                
                Button("Save") {
                    updateStock()
                }
                .padding()
                .disabled(editedStockName.isEmpty || editedStockPrice.isEmpty)
            }
        }
        .padding()
    }
    
    // Sheet for adding stock
    private func addStockSheet() -> some View {
        VStack {
            Text("Add New Stock")
                .font(.headline)
            
            Form {
                TextField("Stock Name", text: $newStockName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .submitLabel(.done)
                    .onSubmit {
                        addNewStock()
                    }
                
                TextField("Stock Price", text: $newStockPrice)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .submitLabel(.done)
                    .onSubmit {
                        addNewStock()
                    }
                
                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .font(.caption)
                }
            }
            .padding()
            
            HStack {
                Button("Cancel") {
                    isAddingStock = false
                    resetInputs()
                }
                .padding()
                
                Button("Save") {
                    addNewStock()
                }
                .padding()
                .disabled(newStockName.isEmpty || newStockPrice.isEmpty)
            }
        }
        .padding()
    }
    
    private func addNewStock() {
        guard !newStockName.isEmpty else {
            errorMessage = "Name cannot be empty."
            return
        }
        
        guard let price = Float(newStockPrice) else {
            errorMessage = "Price must be a valid number."
            return
        }
        
        guard !self.price.contains(where: { $0.name.lowercased() == newStockName.lowercased() }) else {
            errorMessage = "Stock name must be unique."
            return
        }
        
        self.price.append(Stocks(name: newStockName, price: price))
        
        resetInputs()
        isAddingStock = false
    }
    
    private func updateStock() {
        guard let selectedStock = selectedStock else { return }
        
        guard !editedStockName.isEmpty else {
            errorMessage = "Name cannot be empty."
            return
        }
        
        guard let price = Float(editedStockPrice) else {
            errorMessage = "Price must be a valid number."
            return
        }
        
        if self.price.contains(where: { $0.name.lowercased() == editedStockName.lowercased() && $0.id != selectedStock.id }) {
            errorMessage = "Stock name must be unique."
            return
        }
        
        if let index = self.price.firstIndex(where: { $0.id == selectedStock.id }) {
            self.price[index] = Stocks(name: editedStockName, price: price)
        }
        
        resetInputs()
        isEditingStock = false
    }
    
    private func deleteStock(_ stock: Stocks) {
        price.removeAll { $0.id == stock.id }
    }
    
    private func resetInputs() {
        editedStockName = ""
        editedStockPrice = ""
        newStockName = ""
        newStockPrice = ""
        errorMessage = nil
        selectedStock = nil
    }
    
    private func colorForStock(_ name: String) -> Color {
        switch name {
        case "Bitcoin": return .blue
        case "Ethereum": return .green
        case "Solana": return .orange
        default: return .gray
        }
    }
}

