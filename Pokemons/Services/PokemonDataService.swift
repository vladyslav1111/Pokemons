//
//  PokemonDataService.swift
//  Pokemons
//
//  Created by Vladyslav Tkachuk1 on 1/4/21.
//

import Foundation

class PokemonDataService {
    static let shared = PokemonDataService()
    
    func getPokemons(offset: Int, limit: Int, completionHandler: @escaping ([Pokemon]?) -> Void) {
        let urlString = APIKeys.baseURL + "/pokemon?offset=\(offset)&limit=\(limit)"
        request(urlString: urlString) { (response: PokemonResponse?) in
            guard let response = response, let pokemons = response.results else { return completionHandler(nil) }
            var result = [Pokemon]()
            for pokemon in pokemons {
                self.request(urlString: pokemon.url) { (pokemonDetail: Pokemon?) in
                    guard let pokemonDetail = pokemonDetail else { fatalError("Pokemon request error") }
                    result.append(pokemonDetail)
                    if result.count == pokemons.count {
                        completionHandler(result)
                    }
                }
            }
        }
    }
    
    func getPokemonDetails(id: Int, completionHandler: @escaping (Pokemon?) -> Void) {
        let urlString = APIKeys.baseURL + "/pokemon/\(id)"
        request(urlString: urlString) { (pokemon: Pokemon?) in
            completionHandler(pokemon)
        }
    }
    
    private func request<T: Decodable>(urlString: String, completionHandler: @escaping (T?) -> Void) {
        guard let url = URL(string: urlString) else { return completionHandler(nil) }
        NetworkService.request(query: url) { (response: Result<T, Error>) in
            switch response {
            case .success(let data):
                completionHandler(data)
            case .failure(let error):
                print(error.localizedDescription)
                completionHandler(nil)
            }
        }
    }
}
