//
//  FuelEntry.swift
//  FleetioChallenge
//
//  Created by Adolfo Hernandez Garza on 1/27/22.
//

import Foundation
import MapKit

// MARK: - FuelEntryResult

struct FuelEntryResult {
    let fuelEntries: [FuelEntry]
    let lastPage: Int?
}

// MARK: - FuelEntry

struct FuelEntry: Codable, Identifiable {
    
    // MARK: Geolocation
    
    struct Geolocation: Codable {
        let latitude: Double?
        let longitude: Double?
    }
    
    // MARK: Properties
    
    let id: Int
    let costPerHour: Double?
    let costPerMile: Double?
    let gallons: String?
    let fuelTypeName: String?
    let reference: String?
    let vehicleName: String?
    let vendorName: String?
    let creationDateString: String
    let geolocation: Geolocation?
    
    var creationDate: Date? {
        Date.customDateFormatter.date(from: creationDateString)
    }
    
    var creationDateFormatted: String? {
        guard let date = creationDate else { return nil }
        return Date.humanReadableDateFormatter.string(from: date)
    }
    
    var mapAnnotation: MapAnnotation? {
        guard
            let latitude = geolocation?.latitude,
            let longitude = geolocation?.longitude
        else {
            return nil
        }
        
        return MapAnnotation(
            coordinate: CLLocationCoordinate2D(
                latitude: latitude,
                longitude: longitude
            )
        )
    }
    
    // MARK: CodingKeys
    
    enum CodingKeys: String, CodingKey, CaseIterable {
        case id
        case costPerHour = "cost_per_hr"
        case costPerMile = "cost_per_mi"
        case gallons = "us_gallons"
        case fuelTypeName = "fuel_type_name"
        case reference
        case vehicleName = "vehicle_name"
        case vendorName = "vendor_name"
        case creationDateString = "created_at"
        case geolocation
        
        var localizedString: String {
            switch self {
            case .id:
                return "ID"
            case .costPerHour:
                return "Cost Per Hour"
            case .costPerMile:
                return "Cost Per Mile"
            case .gallons:
                return "Gallons"
            case .fuelTypeName:
                return "Fuel Type"
            case .reference:
                return "Reference"
            case .vehicleName:
                return "Vehicle Name"
            case .vendorName:
                return "Vendor Name"
            case .creationDateString:
                return "Creation Date"
            case .geolocation:
                return "Geolocation"
            }
        }
        
        var isFilterEnabled: Bool {
            switch self {
            case .geolocation, .creationDateString:
                return false
            default:
                return true
            }
        }
    }
}

extension FuelEntry.CodingKeys: Identifiable {
    var id: Self { self }
}
