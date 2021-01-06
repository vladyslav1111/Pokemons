//
//  PokemonDetailsViewModel.swift
//  Pokemons
//
//  Created by Vladyslav Tkachuk1 on 1/5/21.
//

import Foundation

class PokemonDetailsViewModel {
    private let pokemon: Pokemon
    
    init(pokemon: Pokemon) {
        self.pokemon = pokemon
    }
    
    func getPokemonName() -> String {
        return pokemon.name
    }
    
    func getFrontImage() -> String {
        return pokemon.sprites.frontDefault
    }
    
    func getBackImage() -> String {
        return pokemon.sprites.backDefault
    }
    
    func getTypes() -> [PokemonType] {
        return pokemon.types
    }
    
    func getStats() -> [Stat] {
        return pokemon.stats
    }
}
