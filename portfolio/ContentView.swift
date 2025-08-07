import SwiftUI

struct ContentView: View {
    
    var body: some View {
        NavigationSplitView {
            
            VStack(alignment: .leading, spacing: 0) {
                
                List {
                    
                    NavigationLink{
                        Dashboard
                    } label: {
                        Label("Dashboard", systemImage: "ellipsis.calendar")
                    }
                    
                    NavigationLink{
                        Investments()
                    }label:{
                        Label("Investment", systemImage: "banknote")
                    }
                    
                    NavigationLink{
                        LocationsDetailsChart()
                    }label: {
                        Label("Real estate", systemImage: "house")
                    }
                }
                .listStyle(SidebarListStyle())
                .navigationTitle("Menu")
                
                
                Spacer()
            }
            .frame(minWidth: 200, maxWidth: 250, alignment: .topLeading)
            
        } detail: {
            
            Text("Alexander, welcome to your dashboard.")
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
        .navigationSplitViewStyle(.automatic)
    }
}


struct RealEstateView: View {
    var body: some View {
        Text("Real Estate Chart")
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
}

#Preview {
    ContentView()
}

