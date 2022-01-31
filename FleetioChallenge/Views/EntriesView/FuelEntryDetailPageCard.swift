//
//  FuelEntryDetailPageCard.swift
//  FleetioChallenge
//
//  Created by Adolfo Hernandez Garza on 1/30/22.
//

import Foundation
import SwiftUI

// MARK: - FuelEntryDetailPageCard

struct FuelEntryDetailPageCard: View {
    
    var title: String
    var subtitle: String
    
    var body: some View {
        ZStack {
            Color.blue.cornerRadius(8)
            
            VStack(spacing: 8) {
                Text(title)
                    .foregroundColor(.white)
                    .bold()
                    .font(.system(size: 20))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text(subtitle).foregroundColor(.white)
                    .foregroundColor(.white)
                    .font(.system(size: 18))
                    .opacity(0.8)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(12)
            .shadow(radius: 3)
        }
    }
}
