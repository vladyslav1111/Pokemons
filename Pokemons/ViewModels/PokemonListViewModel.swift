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
    var pokemons: [Pokemon]?
    var delegate: PokemonListViewModelDelegate?
    
    var numberOfPokemons: Int {
        return pokemons?.count ?? 0
    }
    
    func getPokemonName(withIndex index: Int) -> String {
        return getPokemon(withIndex: index)?.name ?? ""
    }
    
    func getPokemonImageURL(withIndex index: Int) -> String {
        return getPokemon(withIndex: index)?.sprites.frontDefault ?? ""
    }
    
    func getPokemonCellViewModel(forIndex index: Int) -> PokemonCellViewModel {
        let name = getPokemonName(withIndex: index)
        let imageURL = getPokemonImageURL(withIndex: index)
        return PokemonCellViewModel(name: name, imageURL: imageURL)
    }
    
    private func getPokemon(withIndex index: Int) -> Pokemon? {
        if (0..<(pokemons?.count ?? 0)).contains(index) {
            return pokemons?[index]
        }
        return nil
    }
    
    func loadPokemons() {
        PokemonDataService.shared.getPokemons(offset: 0, limit: 50) { [weak self] (pokemons) in
            self?.pokemons = pokemons
            self?.delegate?.reload()
        }
    }
}
