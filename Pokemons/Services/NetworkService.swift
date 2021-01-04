//
//  NetworkService.swift
//  Pokemons
//
//  Created by Vladyslav Tkachuk1 on 1/4/21.
//

import Foundation

enum RequestError: Error {
    case badRequest
    case noData
    case unknownError
}

final class NetworkService {
    static func request<T: Decodable>(query: URL, completion: @escaping (Result<T, Error>) -> Void) {
        URLSession.shared.dataTask(with: query) { (data, response, error) in
            guard error == nil else {
                completion(.failure(error!))
                return
            }
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(RequestError.badRequest))
                return
            }
            guard let data = data else {
                return completion(.failure(RequestError.noData))
            }
            if (200...299).contains(response.statusCode) {
                do {
                    let responseObject = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(responseObject))
                } catch let error {
                    completion(.failure(error))
                }
            } else {
                completion(.failure(RequestError.unknownError))
            }
        }.resume()
    }
}
