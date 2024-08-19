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
    .init(weekday: date(2022, 5, 2), priceHistory: 54), // Monday
    .init(weekday: date(2022, 5, 3), priceHistory: 42), // Tuesday
    .init(weekday: date(2022, 5, 4), priceHistory: 88), // Wednesday
    .init(weekday: date(2022, 5, 5), priceHistory: 49), // Thursday
    .init(weekday: date(2022, 5, 6), priceHistory: 42), // Friday
    .init(weekday: date(2022, 5, 7), priceHistory: 125), // Saturday
    .init(weekday: date(2022, 5, 8), priceHistory: 67)  // Sunday
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
