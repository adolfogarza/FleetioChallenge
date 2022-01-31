//
//  FuelEntryFilterView.swift
//  FleetioChallenge
//
//  Created by Adolfo Hernandez Garza on 1/27/22.
//

import Foundation
import SwiftUI

// MARK: - FuelEntriesView

struct FuelEntryFilterView: View {
    
    // MARK: Properties
    
    let onSave: (_ filters: [URLQueryItem], _ sort: URLQueryItem?) -> Void
    let onDismiss: () -> Void
    
    @ObservedObject var viewModel: FuelEntryFilterViewModel
    
    var body: some View {
        NavigationView {
            List {
                Text("Filter").font(.system(size: 18)).bold()
                ForEach(viewModel.filterModels) { filter in
                    FuelEntryFilterCell(model: filter)
                }
                Text("Sort").font(.system(size: 18)).bold()
                FuelEntryFilterCell(model: viewModel.sortModel)
            }
            .navigationTitle("Advanced Search")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    HStack {
                        Button(
                            action: {
                                onDismiss()
                            },
                            label: {
                                Text("Dismiss").bold()
                            }
                        )
                            .frame(width: 100)
                            .foregroundColor(.white)
                            .padding(.vertical, 6)
                            .background(
                                RoundedRectangle(
                                    cornerRadius: 10,
                                    style: .continuous
                                )
                                    .fill(Color.blue)
                            )
                        
                        Spacer()
                        
                        Button(
                            action: {
                                onSave(viewModel.queryFilters, viewModel.querySort)
                            },
                            label: {
                                Text("Search").bold()
                            }
                        )
                            .frame(width: 100)
                            .foregroundColor(.white)
                            .padding(.vertical, 6)
                            .background(
                                RoundedRectangle(
                                    cornerRadius: 10,
                                    style: .continuous
                                )
                                    .fill(Color.blue)
                            )
                    }
                    .padding(EdgeInsets(top: 0, leading: 40, bottom: 0, trailing: 40))
                }
            }
        }
    }
}

// MARK: - FuelEntryFilterCellModel

class FuelEntryFilterCellModel: ObservableObject, Identifiable {
    
    // MARK: Properties
    
    @Published var fieldType: FuelEntry.CodingKeys
    @Published var filterType: URLBuilder.FilterType
    @Published var value: String
    @Published var isEnabled: Bool
    @Published var isExpanded: Bool
    @Published var sortType: URLBuilder.SortType?
    
    var isSortTypeCell: Bool {
        sortType != nil
    }
    
    static var defaultFilterModels: [FuelEntryFilterCellModel] {
        FuelEntry.CodingKeys.allCases
            .filter { $0.isFilterEnabled }
            .map { fuelEntry in
            FuelEntryFilterCellModel(fieldType: fuelEntry)
        }
    }
    
    static var defaultSortModel: FuelEntryFilterCellModel {
        FuelEntryFilterCellModel(
            fieldType: .id,
            filterType: .matches,
            value: "",
            isEnabled: false,
            isExpanded: false,
            sortType: .descending
        )
    }
    
    // MARK: Initialization
    
    init(
        fieldType: FuelEntry.CodingKeys,
        filterType: URLBuilder.FilterType = .matches,
        value: String = "",
        isEnabled: Bool = false,
        isExpanded: Bool = false,
        sortType: URLBuilder.SortType? = nil
    ) {
        self.fieldType = fieldType
        self.filterType = filterType
        self.value = value
        self.isEnabled = isExpanded
        self.isExpanded = isExpanded
        self.sortType = sortType
    }
}
