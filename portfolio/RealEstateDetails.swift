//
//  RealEstateDetails.swift
//  portfolio
//
//  Created by Alexander Neal on 13/8/24.
//

//
//  LocationDetails.swift
//  PancakeFoodTruck
//
//  Created by Alexander Neal on 13/8/24.
//

import Charts
import SwiftUI

struct Series: Identifiable {
    let city: String
    let sales: [PriceHistory]
    
    var id: String { city }
}

let seriesData: [Series] = [
    .init(city: "VT", sales: VTData),
    .init(city: "MBA", sales: sfData),
]

struct LocationsDetailsChart: View {
    var body: some View {
        Chart(seriesData) { series in
            ForEach(series.sales) { element in
                LineMark(
                    x: .value("Day", element.weekday, unit: .day),
                    y: .value("Sales", element.priceHistory)
                )
                .foregroundStyle(by: .value("City", series.city))
                
            }
        }.padding(.all)
    }
}

struct LocationsDetailsChart_Preview: PreviewProvider {
    static var previews: some View {
        LocationsDetailsChart()
    }
    
    
}
