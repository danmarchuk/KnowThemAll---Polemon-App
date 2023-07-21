//
//  KnowThemAllTests.swift
//  KnowThemAllTests
//
//  Created by Данік on 08/07/2023.
//

import XCTest
@testable import KnowThemAll

final class KnowThemAllTests: XCTestCase {
    
    var pokeManager: PokeManager!
    var mockSession: MockURLSession!

    override func setUp() {
        super.setUp()
        mockSession = MockURLSession()
        pokeManager = PokeManager(session: mockSession)
    }

    override func tearDown() {
        pokeManager = nil
        mockSession = nil
        super.tearDown()
    }

    func testFetchPokemons() {
        // Given
        let urlString = "https://pokeapi.co/api/v2/pokemon/1"
        let expectedPokemon = PokeModel(name: "test", ability: "test", height: 1, weight: 1, moves: "test", power: 1, attack: "test", damage: 1, imageUrl: "test")
        let jsonData = try! JSONEncoder().encode(expectedPokemon)
        mockSession.data = jsonData
        mockSession.response = HTTPURLResponse(url: URL(string: urlString)!, statusCode: 200, httpVersion: nil, headerFields: nil)
        
        // When
        let observable = pokeManager.fetchPokemons()
        
        // Then
        observable.subscribe(onNext: { pokemon in
            XCTAssertEqual(pokemon, expectedPokemon)
        }, onError: { error in
            XCTFail(error.localizedDescription)
        }).dispose()
    }

    func testPerformRequest() {
        // Given
        let urlString = "https://pokeapi.co/api/v2/pokemon/1"
        let expectedPokemon = PokeModel(name: "test", ability: "test", height: 1, weight: 1, moves: "test", power: 1, attack: "test", damage: 1, imageUrl: "test")
        let jsonData = try! JSONEncoder().encode(expectedPokemon)
        mockSession.data = jsonData
        mockSession.response = HTTPURLResponse(url: URL(string: urlString)!, statusCode: 200, httpVersion: nil, headerFields: nil)
        
        // When
        let observable = pokeManager.fetchPokemons()
        
        // Then
        observable.subscribe(onNext: { pokemon in
            XCTAssertEqual(pokemon, expectedPokemon)
        }, onError: { error in
            XCTFail(error.localizedDescription)
        }).dispose()
    }
}

class MockURLSession: URLSession {
    var cachedUrl: URL?
    var data: Data?
    var response: URLResponse?
    var error: Error?
    
    override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        self.cachedUrl = url
        completionHandler(data, response, error)
        return URLSession.shared.dataTask(with: url)
    }
}
