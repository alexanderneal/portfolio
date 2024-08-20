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
    RealEstateProperties(month: 1, amountPrice: 600000),
    RealEstateProperties(month: 2, amountPrice: 610000),
    RealEstateProperties(month: 3, amountPrice: 620000),
    RealEstateProperties(month: 4, amountPrice: 605000),
    RealEstateProperties(month: 5, amountPrice: 607500),
    RealEstateProperties(month: 6, amountPrice: 650000),
    RealEstateProperties(month: 7, amountPrice: 670000),
    RealEstateProperties(month: 8, amountPrice: 675000),
    RealEstateProperties(month: 9, amountPrice: 620000),
    RealEstateProperties(month: 10, amountPrice: 680000),
    RealEstateProperties(month: 11, amountPrice: 687000),
    RealEstateProperties(month: 12, amountPrice: 690000)
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

