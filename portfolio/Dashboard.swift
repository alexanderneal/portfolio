import Charts
import SwiftUI

struct ProfitByCategory: Identifiable {
    let id = UUID()
    let department: String
    let profit: Double
    let productCategory: String
}

let dataDashboard: [ProfitByCategory] = [
    ProfitByCategory(department: "Investments", profit: 1200, productCategory: "tracker"),
    ProfitByCategory(department: "Investments", profit: 3200,productCategory: "tracker"),
    ProfitByCategory(department: "Investments", profit: 1200, productCategory: "tracker"),
    ProfitByCategory(department: "Investments", profit: 3300,productCategory: "tracker"),
    ProfitByCategory(department: "Investments", profit: 6500, productCategory: "tracker"),
    ProfitByCategory(department: "Investments", profit: 4300,productCategory: "tracker"),
    ProfitByCategory(department: "RealEstate", profit: 4000,productCategory: "tracker"),
    ProfitByCategory(department: "RealEstate", profit: 5000,productCategory: "tracker"),
    ProfitByCategory(department: "RealEstate", profit: 4000,productCategory: "tracker"),
    ProfitByCategory(department: "RealEstate", profit: 3000,productCategory: "tracker"),
    ProfitByCategory(department: "RealEstate", profit: 7600,productCategory: "tracker"),
    ProfitByCategory(department: "RealEstate", profit: 8000,productCategory: "tracker")
]

var Dashboard: some View {
    Chart(dataDashboard) { item in
        BarMark(
            x: .value("Category", item.productCategory),
            y: .value("Profit", item.profit)
        ).foregroundStyle(by: .value("Mismo", item.department))
    }.frame(width: 300).padding(.all)
}


#Preview {
    ContentView()
}
