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
    
    func loadPokemons() {
        reachability.whenReachable = { [weak self] reachability in
            self?.pokemonDataService.getPokemons(offset: 0, limit: 20) { [weak self] (pokemons) in
                if let pokemons = pokemons {
                    self?.savePokemons(pokemons)
                }
                self?.pokemons = pokemons
                self?.delegate?.reload()
            }
        }
        reachability.whenUnreachable = { [weak self] _ in
            self?.getCachedPokemons()
            self?.delegate?.reload()
        }

        do {
            try reachability.startNotifier()
        } catch {
            getCachedPokemons()
            self.delegate?.reload()
        }
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
