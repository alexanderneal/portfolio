import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationSplitView {
            List {
                NavigationLink("Dashboard", destination: Dashboard)
                NavigationLink("Investments", destination: Investments())
                NavigationLink("Real Estate", destination: LocationsDetailsChart())
            }
            .navigationTitle("Menu")
            .frame(minWidth: 200)  // Adjust the width of the sidebar
        } detail: {
            Text("Welcome to the dashboard!")
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                
        }
        .navigationSplitViewStyle(.automatic)
    }
}

struct RealEstateView: View {
    var body: some View {
        // Example of showing the chart here
        Text("Real Estate Chart")
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    }
}

#Preview {
    ContentView()
}
