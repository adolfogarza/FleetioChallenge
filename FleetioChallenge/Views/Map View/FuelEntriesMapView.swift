//
//  FuelEntriesMapView.swift
//  FleetioChallenge
//
//  Created by Adolfo Hernandez Garza on 1/27/22.
//

import Foundation
import SwiftUI
import MapKit

// MARK: - FuelEntriesMapView

struct FuelEntriesMapView: View {
    
    // MARK: Properties
    
    @ObservedObject var viewModel: FuelEntriesMapViewModel
    @State private var isFilterScreenPresented = false
    private var filterScreenViewModel = FuelEntryFilterViewModel()
    
    var body: some View {
        ZStack {
            Map(
                coordinateRegion: $viewModel.region,
                interactionModes: .all,
                showsUserLocation: true,
                annotationItems: viewModel.annotations
            ) {
                MapMarker(coordinate: $0.coordinate)
            }
            .navigationTitle("Map View")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(
                        action: {
                            isFilterScreenPresented.toggle()
                        },
                        label: {
                            Image(systemName: "doc.text.magnifyingglass")
                        }
                    )
                        .fullScreenCover(isPresented: $isFilterScreenPresented) {
                            FuelEntryFilterView(
                                onSave: { (filters, sort) in
                                    var queryFilters = filters
                                    
                                    if let sortQuery = sort {
                                        queryFilters.append(sortQuery)
                                    }
                                    
                                    viewModel.cleanAndFetch(withQueryFilters: queryFilters)
                                    isFilterScreenPresented = false
                                },
                                onDismiss: {
                                    isFilterScreenPresented = false
                                },
                                viewModel: filterScreenViewModel
                            )
                        }
                }
            }
            
            if viewModel.isLoading {
                ProgressView().foregroundColor(.black)
            }
        }
    }
    
    // MARK: Initialization
    
    init(viewModel: FuelEntriesMapViewModel) {
        self.viewModel = viewModel
        viewModel.enableLocationServicesIfNeeded()
        viewModel.cleanAndFetch(withQueryFilters: [])
    }
}
