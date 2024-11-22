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

    @State private var isAddingStock: Bool = false
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

            // Chart with display text
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

            Spacer()
        }
        .sheet(isPresented: $isAddingStock) {
            VStack {
                Text("Add New Stock")
                    .font(.headline)

                Form {
                    TextField("Stock Name", text: $newStockName).textFieldStyle(RoundedBorderTextFieldStyle())
                        .onSubmit {addNewStockIfComplete()
                    }
                    
                    TextField("Stock Price", text: $newStockPrice).textFieldStyle(RoundedBorderTextFieldStyle())
                        .onSubmit {
                        addNewStockIfComplete()
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

        // Reset inputs and close modal
        resetInputs()
        isAddingStock = false
    }
    
    private func addNewStockIfComplete() {
        if !newStockName.isEmpty && !newStockPrice.isEmpty {
            addNewStock()
        }
    }

    private func resetInputs() {
        newStockName = ""
        newStockPrice = ""
        errorMessage = nil
    }
}

#Preview {
    Investments()
}

