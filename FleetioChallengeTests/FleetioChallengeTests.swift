//
//  FleetioChallengeTests.swift
//  FleetioChallengeTests
//
//  Created by Adolfo Hernandez Garza on 1/27/22.
//

import XCTest
@testable import FleetioChallenge

class FleetioChallengeTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testEqualFilterQueriesAreBuiltProperly() {
        let initialKeyValuePairs: [(FuelEntry.CodingKeys, String)] = [
            (.id, "1234"),
            (.gallons, "20"),
            (.fuelTypeName, "Diesel"),
            (.vehicleName, "Subaru")
        ]
        
        let initialFilterType: URLBuilder.FilterType = .equals
        
        let expectedResults = [
            URLQueryItem(name: "q[id_eq]", value: "1234"),
            URLQueryItem(name: "q[us_gallons_eq]", value: "20"),
            URLQueryItem(name: "q[fuel_type_name_eq]", value: "Diesel"),
            URLQueryItem(name: "q[vehicle_name_eq]", value: "Subaru")
        ]
        
        let results = initialKeyValuePairs.map { URLBuilder.fuelEntriesFilterQuery(forKey: $0.0, filterType: initialFilterType, value: $0.1)  }
        
        XCTAssertEqual(expectedResults, results)
    }
    
    func testMatchesFilterQueriesAreBuiltProperly() {
        let initialKeyValuePairs: [(FuelEntry.CodingKeys, String)] = [
            (.id, "1234"),
            (.gallons, "20"),
            (.fuelTypeName, "Diesel"),
            (.vehicleName, "Subaru")
        ]
        
        let initialFilterType: URLBuilder.FilterType = .matches
        
        let expectedResults = [
            URLQueryItem(name: "q[id_matches]", value: "1234"),
            URLQueryItem(name: "q[us_gallons_matches]", value: "20"),
            URLQueryItem(name: "q[fuel_type_name_matches]", value: "Diesel"),
            URLQueryItem(name: "q[vehicle_name_matches]", value: "Subaru")
        ]
        
        let results = initialKeyValuePairs.map { URLBuilder.fuelEntriesFilterQuery(forKey: $0.0, filterType: initialFilterType, value: $0.1)  }
        
        XCTAssertEqual(expectedResults, results)
    }
    
    func testLessThanFilterQueriesAreBuiltProperly() {
        let initialKeyValuePairs: [(FuelEntry.CodingKeys, String)] = [
            (.id, "1234"),
            (.gallons, "20"),
            (.fuelTypeName, "Diesel"),
            (.vehicleName, "Subaru")
        ]
        
        let initialFilterType: URLBuilder.FilterType = .lessThan
        
        let expectedResults = [
            URLQueryItem(name: "q[id_lt]", value: "1234"),
            URLQueryItem(name: "q[us_gallons_lt]", value: "20"),
            URLQueryItem(name: "q[fuel_type_name_lt]", value: "Diesel"),
            URLQueryItem(name: "q[vehicle_name_lt]", value: "Subaru")
        ]
        
        let results = initialKeyValuePairs.map { URLBuilder.fuelEntriesFilterQuery(forKey: $0.0, filterType: initialFilterType, value: $0.1)  }
        
        XCTAssertEqual(expectedResults, results)
    }
    
    func testAscendingSortQueriesAreBuiltProperly() {
        let initialKeyValuePairs: [FuelEntry.CodingKeys] = [.id, .gallons, .fuelTypeName, .vehicleName]
        
        let initialSortType: URLBuilder.SortType = .ascending
        
        let expectedResults = [
            URLQueryItem(name: "q[s]", value: "id+asc"),
            URLQueryItem(name: "q[s]", value: "us_gallons+asc"),
            URLQueryItem(name: "q[s]", value: "fuel_type_name+asc"),
            URLQueryItem(name: "q[s]", value: "vehicle_name+asc")
        ]
        
        let results = initialKeyValuePairs.map { URLBuilder.fuelEntriesSortingQuery(forKey: $0, sortType: initialSortType) }
        
        XCTAssertEqual(expectedResults, results)
    }
    
    func testDescendingSortQueriesAreBuiltProperly() {
        let initialKeyValuePairs: [FuelEntry.CodingKeys] = [.id, .gallons, .fuelTypeName, .vehicleName]
        
        let initialSortType: URLBuilder.SortType = .descending
        
        let expectedResults = [
            URLQueryItem(name: "q[s]", value: "id+desc"),
            URLQueryItem(name: "q[s]", value: "us_gallons+desc"),
            URLQueryItem(name: "q[s]", value: "fuel_type_name+desc"),
            URLQueryItem(name: "q[s]", value: "vehicle_name+desc")
        ]
        
        let results = initialKeyValuePairs.map { URLBuilder.fuelEntriesSortingQuery(forKey: $0, sortType: initialSortType) }
        
        XCTAssertEqual(expectedResults, results)
    }
}
