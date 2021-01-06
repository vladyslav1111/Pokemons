//
//  PokemonListViewModel.swift
//  Pokemons
//
//  Created by Vladyslav Tkachuk1 on 1/4/21.
//

import Foundation

protocol PokemonListViewModelDelegate: class {
    func reload()
}

class PokemonListViewModel {
    private var pokemons: [Pokemon]?
    weak var delegate: PokemonListViewModelDelegate?
    
    var numberOfPokemons: Int {
        return pokemons?.count ?? 0
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
    
    private func getPokemon(withIndex index: Int) -> Pokemon? {
        if (0..<(pokemons?.count ?? 0)).contains(index) {
            return pokemons?[index]
        }
        return nil
    }
    
    private func getPokemonName(withIndex index: Int) -> String {
        return getPokemon(withIndex: index)?.name ?? ""
    }
    
    private func getPokemonImageURL(withIndex index: Int) -> String {
        return getPokemon(withIndex: index)?.sprites.frontDefault ?? ""
    }
    
    func loadPokemons() {
        PokemonDataService.shared.getPokemons(offset: 0, limit: 50) { [weak self] (pokemons) in
            self?.pokemons = pokemons
            self?.delegate?.reload()
        }
    }
}
