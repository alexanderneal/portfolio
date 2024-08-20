//
//  Investments.swift
//  portfolio
//
//  Created by Alexander Neal on 11/8/24.
//
import Charts
import SwiftUI

struct Stocks: Identifiable {
    let name: String
    let price: Int
    
    var id: String { name }
    
}

let price: [Stocks] = [
    .init(name: "Bitcoin", price: 1706),
    .init(name: "Ethereum", price: 3870),
    .init(name: "Solana", price: 1916)
]

let mostSold = price.max(by: { $0.price < $1.price })?.name ?? "N/A"


struct Investments: View {
    var body: some View {
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
                    Text("Most Plot")
                        .font(.callout)
                        .foregroundStyle(.secondary)
                    Text(mostSold)
                        .font(.title2.bold())
                        .foregroundColor(.primary)
                }
                .position(x: frame.midX, y: frame.midY)
            }
        }
    }
}

#Preview {
    ContentView()
    
}
