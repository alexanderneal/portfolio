//
//  ContentView.swift
//  portfolio
//
//  Created by Alexander Neal on 9/8/24.
//
import Charts
import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext

    var body: some View {
        NavigationSplitView {
            List {
                NavigationLink("Dashboard",destination: Dashboard())
                NavigationLink("Investments",destination: Investments())
                NavigationLink("RealEstate",destination: RealEstate())
            }
            .navigationSplitViewColumnWidth(min: 180, ideal: 200)
            
        } detail: {
            Text("Welcome to the dashboard!")
        }
    }

    
}

#Preview {
    ContentView()
    
}
