//
//  LocationsToggle.swift
//  PancakeFoodTruck
//
//  Created by Alexander Neal on 13/8/24.
//

import Charts
import SwiftUI

let sfData: [PriceHistory] = [
    .init(weekday: date(2024, 1, 1), priceHistory: 600000),
    .init(weekday: date(2024, 2, 1), priceHistory: 610000),
    .init(weekday: date(2024, 3, 1), priceHistory: 620000),
    .init(weekday: date(2024, 4, 1), priceHistory: 630000),
    .init(weekday: date(2024, 5, 1), priceHistory: 605000),
    .init(weekday: date(2024, 6, 1), priceHistory: 630000),
    .init(weekday: date(2024, 7, 1), priceHistory: 640000),
    .init(weekday: date(2024, 8, 1), priceHistory: 620000),
    .init(weekday: date(2024, 9, 1), priceHistory: 650000),
    .init(weekday: date(2024, 10, 1), priceHistory: 670000),
    .init(weekday: date(2024, 11, 1), priceHistory: 675000),
    .init(weekday: date(2024, 12, 1), priceHistory: 650000),
]

enum City {
    case VT
    case sanFrancisco
}

struct LocationsToggleChart: View {
    @State var city: City = .VT
    
    var data: [PriceHistory] {
        switch city {
        case .VT:
            return VTData
        case .sanFrancisco:
            return sfData
        }
    }
    
    var body: some View {
        VStack {
            Picker("City", selection: $city.animation(.easeInOut)) {
                Text("VT").tag(City.VT)
                Text("San Francisco").tag(City.sanFrancisco)
            }
            .pickerStyle(.segmented)
            
            Chart(data) { element in
                LineMark(
                    x: .value("Day", element.weekday, unit: .day),
                    y: .value("Sales", element.priceHistory)
                )
            }
        }
    }
}

struct LocationsToggleChart_Previews: PreviewProvider {
    static var previews: some View {
        LocationsToggleChart()
    }
}

