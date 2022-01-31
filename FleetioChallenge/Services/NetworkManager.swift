//
//  NetworkManager.swift
//  FleetioChallenge
//
//  Created by Adolfo Hernandez Garza on 1/27/22.
//

import Foundation

// MARK: - NetworkManagerError

enum NetworkManagerError: Error {
    case urlFailedToBuild
    case missingData
}

// MARK: - NetworkManager

class NetworkManager {
    
    // MARK: Constants
    
    struct Constants {
        static let pageCount = "X-Pagination-Total-Pages"
    }
    
    // MARK: Typealias
    
    typealias FuelEntryCompletion = (Result<FuelEntryResult, Error>) -> Void
    
    // MARK: Helpers
    
    func fetchFuelEntries(withURLRequest urlRequest: URLRequest, completion: @escaping FuelEntryCompletion) {
        URLSession.shared.dataTask(with: urlRequest) { (data: Data?, response: URLResponse? , error: Error?) in
            if let error = error {
                completion(.failure(error))
                return
            }
                        
            guard let data = data else {
                completion(.failure(NetworkManagerError.missingData))
                return
            }
            
            var pageCount: Int?
            
            if
                let httpResponse = response as? HTTPURLResponse,
                let pageCountValue = httpResponse.value(forHTTPHeaderField: Constants.pageCount)
            {
                pageCount = Int(pageCountValue)
            }
            
            do {
                let fuelEntries = try JSONDecoder().decode([FuelEntry].self, from: data)
                completion(.success(FuelEntryResult(fuelEntries: fuelEntries, lastPage: pageCount)))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
