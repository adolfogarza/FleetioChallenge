//
//  FuelEntryDetailPageView.swift
//  FleetioChallenge
//
//  Created by Adolfo Hernandez Garza on 1/27/22.
//

import Foundation
import SwiftUI

// MARK: - FuelEntryDetailPageView

struct FuelEntryDetailPageView: View {
    
    // MARK: Properties
    
    let model: FuelEntry
    
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                FuelEntryDetailPageCard(title: "Fuel Entry ID", subtitle: "\(model.id)")
                
                if let creationDate = model.creationDateFormatted {
                    FuelEntryDetailPageCard(title: "Creation Date:", subtitle: creationDate)
                }
                
                if let vehicleName = model.vehicleName {
                    FuelEntryDetailPageCard(title: "Vehicle Name", subtitle: vehicleName)
                }
                
                if let vendorName = model.vendorName {
                    FuelEntryDetailPageCard(title: "Vendor Name", subtitle: vendorName)
                }
                
                if let costPerHour = model.costPerHour {
                    FuelEntryDetailPageCard(title: "Cost Per Hour", subtitle: "\(costPerHour)")
                }
                
                if let costPerMile = model.costPerMile {
                    FuelEntryDetailPageCard(title: "Cost Per Mile", subtitle: "\(costPerMile)")
                }
                
                if let gallons = model.gallons {
                    FuelEntryDetailPageCard(title: "Gallons", subtitle: gallons)
                }
                
                if let fuelType = model.fuelTypeName {
                    FuelEntryDetailPageCard(title: "Fuel Type", subtitle: fuelType)
                }
                
                if let reference = model.reference, !reference.isEmpty {
                    FuelEntryDetailPageCard(title: "Reference", subtitle: reference)
                }
            }
            .fixedSize(horizontal: false, vertical: true)
            .padding(EdgeInsets(top: 20, leading: 10, bottom: 0, trailing: 10))
        }
        .navigationTitle("Fuel Entry")
        .navigationBarTitleDisplayMode(.inline)
    }
}

