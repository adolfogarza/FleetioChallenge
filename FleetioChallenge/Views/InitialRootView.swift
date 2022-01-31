//
//  InitialRootView.swift
//  FleetioChallenge
//
//  Created by Adolfo Hernandez Garza on 1/27/22.
//

import Foundation
import SwiftUI


struct InitialRootView: View {
    enum TabItem {
        case fuelEntries
        case mapView
    }
    
    @State var selectedTabItem: TabItem = .fuelEntries
    
    var body: some View {
        TabView() {
            NavigationView {
                FuelEntriesView(viewModel: FuelEntriesViewModel())
            }
            .tabItem {
                Image(systemName: "fuelpump.circle.fill")
                Text("Fuel Entries")
            }
            .tag(TabItem.fuelEntries)
            
            NavigationView {
                FuelEntriesMapView(viewModel: FuelEntriesMapViewModel())
            }
            .tabItem {
                Image(systemName: "map.circle.fill")
                Text("Map View")
            }
            .tag(TabItem.mapView)
        }
    }
}
