import SwiftUI

struct RealEstateDetail: View {
    let realEstate: RealEstate
    
    var body: some View {
        VStack {
            Text(realEstate.name)
                .font(.title)
                .padding()
            Text("Monetary Value: \(realEstate.monetary)")
            Text("Date: \(realEstate.date, formatter: dateFormatter)")
        }
        .navigationTitle(realEstate.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}
