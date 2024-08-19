//
//  LocationsToggle.swift
//  PancakeFoodTruck
//
//  Created by Alexander Neal on 13/8/24.
//

import Charts
import SwiftUI

let sfData: [PriceHistory] = [
    .init(weekday: date(2022, 5, 2), priceHistory: 81),
    .init(weekday: date(2022, 5, 3), priceHistory: 90),
    .init(weekday: date(2022, 5, 4), priceHistory: 52),
    .init(weekday: date(2022, 5, 5), priceHistory: 72),
    .init(weekday: date(2022, 5, 6), priceHistory: 84),
    .init(weekday: date(2022, 5, 7), priceHistory: 84),
    .init(weekday: date(2022, 5, 8), priceHistory: 137)
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

