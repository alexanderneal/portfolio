import Charts
import SwiftUI

struct RealEstateProperties: Identifiable {
    var id: Date { date }  // Use the date as the identifier
    
    var date: Date
    var Amount: Double

    init(month: Int, amountPrice: Double) {
        let calendar = Calendar.autoupdatingCurrent
        self.date = calendar.date(from: DateComponents(year: 2020, month: month))!
        self.Amount = amountPrice
    }
}

var data: [RealEstateProperties] = [
    RealEstateProperties(month: 1, amountPrice: 74),
    RealEstateProperties(month: 2, amountPrice: 99),
    RealEstateProperties(month: 3, amountPrice: 62),
    RealEstateProperties(month: 4, amountPrice: 80),
    RealEstateProperties(month: 5, amountPrice: 87),
    RealEstateProperties(month: 6, amountPrice: 98)
]

struct Brick: View {
    var body: some View {
        Chart(data) {
            LineMark(
                x: .value("Month", $0.date),
                y: .value("Hours of Sunshine", $0.Amount)
            ).cornerRadius(1.5, style: .circular)
        }.padding(.all)
    }
}

#Preview {
    ContentView()
}

