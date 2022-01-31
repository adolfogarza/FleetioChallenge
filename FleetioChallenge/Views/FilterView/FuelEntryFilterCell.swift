//
//  FuelEntryFilterCell.swift
//  FleetioChallenge
//
//  Created by Adolfo Hernandez Garza on 1/30/22.
//

import Foundation
import SwiftUI

// MARK: - FuelEntryFilterCell

struct FuelEntryFilterCell: View {
    
    // MARK: Properties

    @ObservedObject var model: FuelEntryFilterCellModel
    
    var body: some View {
        let sortType = "\(model.isSortTypeCell ? "Sort" : "Filter")"
        
        DisclosureGroup(
            isExpanded: $model.isExpanded,
            content: {
                Toggle("\(sortType) Enabled", isOn: $model.isEnabled)
                
                HStack {
                    Text("Field Name")
                    Spacer()
                    Text(model.fieldType.localizedString)
                        .bold()
                }
                
                HStack {
                    Text("\(model.isSortTypeCell ? "Sort Type" : "Filter Type")")
                    Spacer()
                    Text("\(model.isSortTypeCell ? model.sortType?.localizedString ?? "" : model.filterType.localizedString)")
                        .bold()
                }
                
                if model.isSortTypeCell == false {
                    HStack {
                        Text("Value")
                        Spacer().frame(width: 120)
                        TextField("Enter Value Here", text: $model.value)
                    }
                }
                
                if model.isSortTypeCell {
                    HStack {
                        Spacer()
                        Menu("Tap Here To Change Sort Type") {
                            ForEach(URLBuilder.SortType.allCases) { sort in
                                Button(sort.localizedString, action: { model.sortType = sort })
                            }
                        }
                        Spacer()
                    }
                } else {
                    HStack {
                        Spacer()
                        Menu("Tap Here To Change Filter Type") {
                            ForEach(URLBuilder.FilterType.allCases) { filter in
                                Button(filter.localizedString, action: { model.filterType = filter })
                            }
                        }
                        Spacer()
                    }
                }
                
                if model.isSortTypeCell {
                    HStack {
                        Spacer()
                        Menu("Tap Here To Change Field Type") {
                            ForEach(FuelEntry.CodingKeys.allCases) { entry in
                                Button(entry.localizedString, action: { model.fieldType = entry })
                            }
                        }
                        Spacer()
                    }
                }
            },
            label: {
                if model.isEnabled {
                    HStack {
                        Text(model.fieldType.localizedString)
                        Spacer()
                        Text("Enabled").bold()
                    }
                } else {
                    HStack {
                        Text(model.fieldType.localizedString)
                        Spacer()
                        Text("Disabled")
                    }
                }
            }
        )
    }
}
