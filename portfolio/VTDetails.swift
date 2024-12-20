//
//  CupertinoDetails.swift
//  PancakeFoodTruck
//
//  Created by Alexander Neal on 13/8/24.
//

import Charts
import SwiftUI

func date(_ year: Int, _ month: Int, _ day: Int) -> Date {
    return Calendar.current.date(from: DateComponents(year: year, month: month, day: day)) ?? Date()
}

struct PriceHistory: Identifiable {
    let weekday: Date
    let priceHistory: Int
    
    var id: Date { weekday }
}

let VTData: [PriceHistory] = [
    .init(weekday: date(2024, 1, 1), priceHistory: 300000),
    .init(weekday: date(2024, 2, 1), priceHistory: 610000),
    .init(weekday: date(2024, 3, 1), priceHistory: 620000),
    .init(weekday: date(2024, 4, 1), priceHistory: 405000),
    .init(weekday: date(2024, 5, 1), priceHistory: 607500),
    .init(weekday: date(2024, 6, 1), priceHistory: 450000),
    .init(weekday: date(2024, 7, 1), priceHistory: 470000),
    .init(weekday: date(2024, 8, 1), priceHistory: 475000),
    .init(weekday: date(2024, 9, 1), priceHistory: 620000),
    .init(weekday: date(2024, 10, 1), priceHistory: 780000),
    .init(weekday: date(2024, 11, 1), priceHistory: 887000),
    .init(weekday: date(2024, 12, 1), priceHistory: 790000),
]

struct VTDetailsChart: View {
    var body: some View {
        Chart(VTData) { element in
            AreaMark(
                x: .value("Day", element.weekday, unit: .day),
                y: .value("Sales", element.priceHistory)
            )
        }.padding()
    }
}


struct VTDetailsChart_Previews: PreviewProvider {
    static var previews: some View {
       VTDetailsChart()
    }
}
