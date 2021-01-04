//
//  PokemonResponse.swift
//  Pokemons
//
//  Created by Vladyslav Tkachuk1 on 1/4/21.
//

import Foundation

struct PokemonResponse: Decodable {
    let count: Int?
    let next: String?
    let previous: String?
    let results: [Result]?
    
    struct Result: Decodable {
        let name: String
        let url: String
    }
}
