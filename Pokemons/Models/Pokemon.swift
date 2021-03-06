//
//  Pokemon.swift
//  Pokemons
//
//  Created by Vladyslav Tkachuk1 on 1/4/21.
//

import Foundation

public class Pokemon: Decodable {
    let id: Int
    let name: String
    let sprites: Sprites
    let stats: [Stat]
    let types: [PokemonType]
    
    init(id: Int, name: String, stats: [Stat], types: [PokemonType], sprites: Sprites) {
        self.id = id
        self.name = name
        self.stats = stats
        self.types = types
        self.sprites = sprites
    }
    
    struct Sprites: Decodable {
        let backDefault: String
        let frontDefault: String
        
        private enum CodingKeys: String, CodingKey {
            case backDefault = "back_default"
            case frontDefault = "front_default"
        }
    }
}

public class Stat: Decodable {
    let baseStat: Int
    let effort: Int
    let name: String
    
    private enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case effort
        case stat
    }
    
    private enum StatKeys: String, CodingKey {
        case name
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        baseStat = try container.decode(Int.self, forKey: .baseStat)
        effort = try container.decode(Int.self, forKey: .effort)
        let nestedContainer = try container.nestedContainer(keyedBy: StatKeys.self, forKey: .stat)
        name = try nestedContainer.decode(String.self, forKey: .name)
    }
    
    init(baseStat: Int, effort: Int, name: String) {
        self.baseStat = baseStat
        self.effort = effort
        self.name = name
    }
}

public class PokemonType: Decodable {
    let slot: Int
    let name: String
    
    private enum CodingKeys: String, CodingKey {
        case slot
        case type
    }
    
    private enum TypeKeys: String, CodingKey {
        case name
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        slot = try container.decode(Int.self, forKey: .slot)
        let nestedContainer = try container.nestedContainer(keyedBy: TypeKeys.self, forKey: .type)
        name = try nestedContainer.decode(String.self, forKey: .name)
    }
    
    init(slot: Int, name: String) {
        self.slot = slot
        self.name = name
    }
}
