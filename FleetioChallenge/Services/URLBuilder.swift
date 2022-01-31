//
//  URLBuilder.swift
//  FleetioChallenge
//
//  Created by Adolfo Hernandez Garza on 1/27/22.
//

import Foundation

// MARK: - URLBuilder

class URLBuilder {
    
    // MARK: FilterType
    
    enum FilterType: String, CaseIterable {
        case equals = "eq"
        case matches
        case lessThan = "lt"
        case lessThanOrEqualTo = "lteq"
        case greaterThan = "gt"
        case greaterThanOrEqualTo = "gteq"
        case contains = "cont"
        
        var localizedString: String {
            switch self {
            case .equals:
                return "Equals"
            case .matches:
                return "Matches"
            case .lessThan:
                return "Less Than"
            case .lessThanOrEqualTo:
                return "Less Than or Equal To"
            case .greaterThan:
                return "Greater Than"
            case .greaterThanOrEqualTo:
                return "Greater Than or Equal To"
            case .contains:
                return "Contains"
            }
        }
    }
    
    // MARK: SortType
    
    enum SortType: String, CaseIterable {
        case ascending = "asc"
        case descending = "desc"
        
        var localizedString: String {
            switch self {
            case .ascending:
                return "Ascending"
            case .descending:
                return "Descending"
            }
        }
    }
    
    // MARK: Constants
    
    private struct Constants {
        static let authorization = "Token token=a3ddc620b35b609682192c167de1b1f3f5100387"
        static let accountToken = "798819214b"
    }
    
    // MARK: Helpers
     
    static func fuelEntriesFilterQuery(
        forKey key: FuelEntry.CodingKeys,
        filterType: FilterType,
        value: String
    ) -> URLQueryItem? {
        guard !value.isEmpty else { return nil }
        
        let query = "q[\(key.rawValue)_\(filterType.rawValue)]"
        
        return URLQueryItem(name: query, value: value)
    }
    
    static func fuelEntriesSortingQuery(forKey key: FuelEntry.CodingKeys, sortType: SortType) -> URLQueryItem {
        let query = "q[s]"
        let value = "\(key.rawValue)+\(sortType.rawValue)"
        
        return URLQueryItem(name: query, value: value)
    }
    
    static func generateFuelEntriesURLRequest(forPage page: Int = 1, queries: [URLQueryItem] = []) -> URLRequest? {
        var queryItems = queries
        
        queryItems.append(URLQueryItem(name: "page", value: String(page)))
        
        var urlComponents = URLComponents()
        
        urlComponents.scheme = "https"
        urlComponents.host = "secure.fleetio.com"
        urlComponents.path = "/api/v1/fuel_entries"
        urlComponents.queryItems = queryItems
        
        guard let baseURL = urlComponents.url else { return nil }
        
        print("found: \(baseURL.absoluteURL)")
        
        var urlRequest = URLRequest(url: baseURL)
        
        urlRequest.addValue(Constants.authorization, forHTTPHeaderField: "Authorization")
        urlRequest.addValue(Constants.accountToken, forHTTPHeaderField: "Account-Token")
        
        return urlRequest
    }
}

// MARK: - Identifiable

extension URLBuilder.FilterType: Identifiable {
    var id: Self { self }
}

extension URLBuilder.SortType: Identifiable {
    var id: Self { self }
}
