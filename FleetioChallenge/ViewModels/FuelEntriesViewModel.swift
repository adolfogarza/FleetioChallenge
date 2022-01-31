//
//  FuelEntriesViewModel.swift
//  FleetioChallenge
//
//  Created by Adolfo Hernandez Garza on 1/27/22.
//

import Foundation

// MARK: - FuelEntriesViewModel

class FuelEntriesViewModel: ObservableObject {
    
    // MARK: Properties
    
    @Published var entries: [FuelEntry] = []
    @Published var isLoading: Bool = false
    
    private var lastPage: Int?
    private var currentPage = 0
    private var queryFilters: [URLQueryItem] = []
    private let networkManager: NetworkManager
    
    // MARK: Initialization
    
    init() {
        networkManager = NetworkManager()
    }
    
    // MARK: Helpers
    
    func cleanAndFetch(withQueryFilters filters: [URLQueryItem]) {
        queryFilters = filters
        entries = []
        currentPage = 0
        lastPage = nil
        fetchUpcomingPage()
    }
    
    func fetchUpcomingPageIfNeeded(withEntryID entryID: Int) {
        if let lastPage = lastPage, currentPage >= lastPage {
            return
        }
        
        guard entryID == entries[entries.endIndex - 1].id else {
            return
        }
        
        fetchUpcomingPage()
    }
    
    func fetchUpcomingPage() {
        let requestURL = URLBuilder.generateFuelEntriesURLRequest(forPage: currentPage + 1, queries: queryFilters)
        
        guard isLoading == false, let requestURL = requestURL else { return }
        
        isLoading = true
        
        networkManager.fetchFuelEntries(withURLRequest: requestURL) { [weak self] result in
            guard let strongSelf = self else { return }
            
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    let upcomingPage = response.fuelEntries
                    strongSelf.lastPage = response.lastPage
                    strongSelf.entries.append(contentsOf: upcomingPage)
                    strongSelf.currentPage += 1
                    
                case.failure(let error):
                    print(error.localizedDescription)
                }
                
                strongSelf.isLoading = false
            }
        }
    }
}
