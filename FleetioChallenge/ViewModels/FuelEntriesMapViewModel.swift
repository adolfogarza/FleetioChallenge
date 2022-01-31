//
//  FuelEntriesMapViewModel.swift
//  FleetioChallenge
//
//  Created by Adolfo Hernandez Garza on 1/30/22.
//

import Foundation
import SwiftUI
import MapKit

// MARK: - FuelEntriesMapViewModel

class FuelEntriesMapViewModel: NSObject, ObservableObject {
    
    // MARK: Properties
    
    @Published var annotations: [MapAnnotation] = []
    @Published var isLoading: Bool = false
    @Published var region: MKCoordinateRegion = .init()

    private var queryFilters: [URLQueryItem] = []
    private var locationManager: CLLocationManager?
    private let networkManager: NetworkManager
    
    // MARK: Initialization
    
    override init() {
        networkManager = NetworkManager()
    }
    
    // MARK: Helpers
    
    func cleanAndFetch(withQueryFilters filters: [URLQueryItem]) {
        queryFilters = filters
        annotations = []
        fetchLocations()
    }
    
    func fetchLocations() {
        let requestURL = URLBuilder.generateFuelEntriesURLRequest(forPage: 1, queries: queryFilters)
        
        guard isLoading == false, let requestURL = requestURL else { return }
        
        isLoading = true
        
        networkManager.fetchFuelEntries(withURLRequest: requestURL) { [weak self] result in
            guard let strongSelf = self else { return }
            
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    strongSelf.annotations = response.fuelEntries.compactMap { $0.mapAnnotation }
                case.failure(let error):
                    print(error.localizedDescription)
                }
                
                strongSelf.isLoading = false
            }
        }
    }
    
    func enableLocationServicesIfNeeded() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager?.desiredAccuracy = .greatestFiniteMagnitude
            locationManager?.delegate = self
        } else {
            print("Location services is not enabled")
        }
    }
    
    private func verifyLocationAuthorization() {
        guard let locationManager = locationManager else {
            return
        }

        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("Location is restricted")
        case .denied:
            print("Location is denied")
        case .authorizedAlways, .authorizedWhenInUse:
            guard let center = locationManager.location?.coordinate else { break }
            region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 20, longitudeDelta: 20))
        @unknown default:
            break
        }
    }
}

// MARK: - FuelEntriesMapViewModel

extension FuelEntriesMapViewModel: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        verifyLocationAuthorization()
    }
}
