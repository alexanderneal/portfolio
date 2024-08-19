import SwiftUI

struct RealEstateDetailView: View {
    let realEstate: RealEstate
    
    var body: some View {
        VStack {
            Text(realEstate.name)
                .font(.largeTitle)
                .padding()
            Text("Monetary Value: \(realEstate.monetary)")
            Text("Date: \(realEstate.date, formatter: dateFormatter)")
        }
        .navigationTitle(realEstate.name)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

