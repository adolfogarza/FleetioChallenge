//
//  MapAnnotation.swift
//  FleetioChallenge
//
//  Created by Adolfo Hernandez Garza on 1/30/22.
//

import Foundation
import MapKit

struct MapAnnotation: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
}
