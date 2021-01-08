//
//  PokemonListViewModel.swift
//  Pokemons
//
//  Created by Vladyslav Tkachuk1 on 1/4/21.
//

import Foundation
import Reachability

protocol PokemonListViewModelDelegate: class {
    func reload()
}

class PokemonListViewModel {
    private var pokemons: [Pokemon]?
    private let reachability: Reachability
    private let pokeponKey: NSString = "pokemons"
    
    private let limit = 20
    private(set) var pageNumber = 0
    
    var numberOfPokemons: Int {
        return pokemons?.count ?? 0
    }
    
    weak var delegate: PokemonListViewModelDelegate?
    let pokemonsCache: NSCache<NSString, NSArray>
    var pokemonDataService = PokemonDataService.shared
    
    init() {
        self.reachability = try! Reachability()
        self.pokemonsCache = NSCache<NSString, NSArray>()
    }
    
    func getPokemonCellViewModel(forIndex index: Int) -> PokemonCellViewModel {
        let name = getPokemonName(withIndex: index)
        let imageURL = getPokemonImageURL(withIndex: index)
        return PokemonCellViewModel(name: name, imageURL: imageURL)
    }
    
    func getDetailsViewModel(forIndex index: Int) -> PokemonDetailsViewModel? {
        guard let pokemon = getPokemon(withIndex: index) else { return nil }
        return PokemonDetailsViewModel(pokemon: pokemon)
    }
    
    func loadPokemons(forPage page: Int = 0) {
        switch reachability.connection {
        case .none, .unavailable:
            getCachedPokemons()
            delegate?.reload()
        default:
            pokemonDataService.getPokemons(offset: self.limit * page, limit: self.limit) { [weak self] (pokemons) in
                self?.pageNumber = page
                if let pokemons = pokemons {
                    self?.savePokemons(pokemons)
                }
                self?.pokemons = pokemons
                self?.delegate?.reload()
            }
        }
    }
    
    func loadNextPagePokemons() {
        loadPokemons(forPage: pageNumber + 1)
    }
    
    func loadPrevPagePokemons() {
        guard pageNumber != 0 else {
            delegate?.reload()
            return		
        }
        loadPokemons(forPage: pageNumber - 1)
    }
}

private extension PokemonListViewModel {
    func getPokemon(withIndex index: Int) -> Pokemon? {
        if (0..<(pokemons?.count ?? 0)).contains(index) {
            return pokemons?[index]
        }
        return nil
    }
    
    func getPokemonName(withIndex index: Int) -> String {
        return getPokemon(withIndex: index)?.name ?? ""
    }
    
    func getPokemonImageURL(withIndex index: Int) -> String {
        return getPokemon(withIndex: index)?.sprites.frontDefault ?? ""
    }
    
    func getCachedPokemons() {
        if let pokemons = pokemonsCache.object(forKey: pokeponKey) {
            self.pokemons = Array(_immutableCocoaArray: pokemons)
        } else {
            pokemons = []
        }
    }
    
    func savePokemons(_ pokemons: [Pokemon]) {
        let pokemonsarray = pokemons as NSArray
        pokemonsCache.setObject(pokemonsarray, forKey: pokeponKey)
    }
}
