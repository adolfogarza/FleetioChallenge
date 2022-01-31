//
//  FuelEntryFilterViewModel.swift
//  FleetioChallenge
//
//  Created by Adolfo Hernandez Garza on 1/30/22.
//

import Foundation
import SwiftUI

class FuelEntryFilterViewModel: ObservableObject {
    
    // MARK: Properties
    
    @Published var filterModels: [FuelEntryFilterCellModel]
    @Published var sortModel: FuelEntryFilterCellModel
    
    var queryFilters: [URLQueryItem] {
        filterModels
            .filter { $0.isEnabled }
            .compactMap {
                URLBuilder.fuelEntriesFilterQuery(
                    forKey: $0.fieldType,
                    filterType: $0.filterType,
                    value: $0.value
                )
            }
    }
    
    var querySort: URLQueryItem? {
        guard let sortType = sortModel.sortType, sortModel.isEnabled else { return nil }
        
        return URLBuilder.fuelEntriesSortingQuery(forKey: sortModel.fieldType, sortType: sortType)
    }
    
    // MARK: Initialization
    
    init(
        filterModels: [FuelEntryFilterCellModel] = FuelEntryFilterCellModel.defaultFilterModels,
        sortModel: FuelEntryFilterCellModel = FuelEntryFilterCellModel.defaultSortModel
    ) {
        self.filterModels = filterModels
        self.sortModel = sortModel
    }
}
