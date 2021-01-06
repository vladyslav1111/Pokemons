//
//  PokemonListViewModelTests.swift
//  PokemonsTests
//
//  Created by Vladyslav Tkachuk1 on 1/6/21.
//

import XCTest
@testable import Pokemons

class PokemonListViewModelTests: XCTestCase {
    
    var testedObject: PokemonListViewModel!
    var delegate: TestDelegate!
    var expectation: XCTestExpectation!
    var mockDataService: MockPokemonDataService!
    
    override func setUp() {
        testedObject = PokemonListViewModel()
        expectation = XCTestExpectation(description: "Loading pokemons")
        mockDataService = MockPokemonDataService()
        delegate = TestDelegate()
        delegate.expectation = expectation
        testedObject.pokemonDataService = mockDataService
        testedObject.delegate = delegate
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
        testedObject = nil
        delegate = nil
        expectation = nil
        mockDataService = nil
    }
    
    func test_numberOfPokemons_nilPokemons_returnsZero() {
        XCTAssertEqual(testedObject.numberOfPokemons, 0)
    }
    
    func test_getPokemonCellViewModel_withNilPokemons_returnsEmptyProperties() {
        let cellModel = testedObject.getPokemonCellViewModel(forIndex: 0)
        XCTAssert(cellModel.imageURL.isEmpty)
        XCTAssert(cellModel.name.isEmpty)
    }
    
    func test_getDetailsViewModel_withNilPokemons_nil() {
        XCTAssertNil(testedObject.getDetailsViewModel(forIndex: 0))
    }
    
    func test_loadPokemons_withNotFailedRequest_returnsPokemons() {
        testedObject.loadPokemons()
        wait(for: [expectation], timeout: 1)
        XCTAssert(testedObject.numberOfPokemons == 1)
    }
    
    func test_loadPokemons_withFailedRequest_returnsNil() {
        mockDataService.isFailedRequest = true
        testedObject.loadPokemons()
        wait(for: [expectation], timeout: 1)
        XCTAssert(testedObject.numberOfPokemons == 0)
    }
    
    func test_loadPokemons_withNotFailedRequest_shouldCachePokemons() {
        testedObject.loadPokemons()
        wait(for: [expectation], timeout: 1)
        if let pokemons = testedObject.pokemonsCache.object(forKey: "pokemons") {
            let cachedPokemon: Pokemon = Array(_immutableCocoaArray: pokemons)[0]
            let name = testedObject.getDetailsViewModel(forIndex: 0)?.getPokemonName()
            XCTAssertEqual(name, cachedPokemon.name)
        } else {
            XCTFail("Unknow cache key or pokemon has not been cached")
        }
    }
    
    func test_loadPokemons_withFailedRequest_shouldNotCachePokemons() {
        mockDataService.isFailedRequest = true
        testedObject.loadPokemons()
        wait(for: [expectation], timeout: 1)
        if let pokemons = testedObject.pokemonsCache.object(forKey: "pokemons") { // Old cached data
            let cachedPokemon: Pokemon = Array(_immutableCocoaArray: pokemons)[0]
            let name = testedObject.getDetailsViewModel(forIndex: 0)?.getPokemonName()
            XCTAssertNotEqual(name, cachedPokemon.name)
        } else {
            XCTAssert(true)
        }
    }

}

class MockPokemonDataService: PokemonDataService {
    var isFailedRequest = false
    override func getPokemons(offset: Int, limit: Int, completionHandler: @escaping ([Pokemon]?) -> Void) {
        if !isFailedRequest {
            let time = Date()
            let pokemons = [Pokemon(id: 0, name: time.description, stats: [Stat(baseStat: 1, effort: 1, name: "1")], types: [PokemonType(slot: 1, name: "1")], sprites: .init(backDefault: "1", frontDefault: "1"))]
            completionHandler(pokemons)
        } else {
            completionHandler(nil)
        }
    }
}

class TestDelegate: PokemonListViewModelDelegate {
    var expectation: XCTestExpectation!
    func reload() {
        expectation.fulfill()
    }
}
