//
//  FuelEntriesView.swift
//  FleetioChallenge
//
//  Created by Adolfo Hernandez Garza on 1/27/22.
//

import Foundation
import SwiftUI

// MARK: - FuelEntriesView

struct FuelEntriesView: View {
    
    // MARK: Properties
    
    @ObservedObject var viewModel: FuelEntriesViewModel
    @State private var isFilterScreenPresented = false
    private var filterScreenViewModel = FuelEntryFilterViewModel()
    
    var body: some View {
        ZStack {
            ScrollView {
                LazyVStack {
                    if viewModel.entries.isEmpty, !viewModel.isLoading {
                        VStack(spacing: 15) {
                            Text("The search did not found any results.").bold()
                            Text("Please try other search parameters.").bold()
                            Image(systemName: "icloud.slash.fill")
                        }
                        .frame(height: 200)
                    } else {
                        ForEach(viewModel.entries) { fuelEntry in
                            NavigationLink(destination: FuelEntryDetailPageView(model: fuelEntry)) {
                                FuelEntryCellView(model: fuelEntry)
                                    .onAppear {
                                        viewModel.fetchUpcomingPageIfNeeded(withEntryID: fuelEntry.id)
                                    }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Fuel Entries")
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
    
    init(viewModel: FuelEntriesViewModel) {
        self.viewModel = viewModel
        
        viewModel.fetchUpcomingPage()
    }
}
