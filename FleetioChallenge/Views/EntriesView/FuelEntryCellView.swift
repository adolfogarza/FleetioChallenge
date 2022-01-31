//
//  FuelEntryCellView.swift
//  FleetioChallenge
//
//  Created by Adolfo Hernandez Garza on 1/27/22.
//

import Foundation
import SwiftUI

// MARK: - FuelEntryCellView

struct FuelEntryCellView: View {
    
    // MARK: Properties
    
    let model: FuelEntry
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 15) {
                Image(systemName: "car.circle.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                VStack(alignment: .leading) {
                    Text("Entry ID: \(model.id)").foregroundColor(.black).bold()
                    Text("Vehicle: \(model.vehicleName ?? "")").foregroundColor(.black)
                    Text("Date: \(model.creationDateFormatted ?? "")").foregroundColor(.black)
                }
            }
            
            Divider()
        }
        .frame(height: 80)
        .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 30))
    }
    
    // MARK: Initialization
    
    init(model: FuelEntry) {
        self.model = model
    }
}
