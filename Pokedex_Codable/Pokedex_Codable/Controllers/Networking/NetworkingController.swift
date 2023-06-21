//
//  NetworkingController.swift
//  Pokedex_Codable
//
//  Created by Karl Pfister on 2/7/22.
//

import Foundation
import UIKit.UIImage

class NetworkingController {
    
    private static let baseURLString = "https://pokeapi.co"
    
    static func fetchPokemon(with searchTerm: String, completion: @escaping (Result<PokemonDict, ResultError>) -> Void) {
        
        guard let baseURL = URL(string: baseURLString) else {return}
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        urlComponents?.path = "/api/v2/pokemon/\(searchTerm.lowercased())"

        guard let finalURL = urlComponents?.url else {return}
        print(finalURL)
        
        URLSession.shared.dataTask(with: finalURL) { dTaskData, _, error in
            if let error = error {
                print("Encountered error: \(error.localizedDescription)")
                completion(.failure(.thrownError(error)))
            }
            
            guard let pokemonData = dTaskData else {return}
            
            do {
                let pokemon = try JSONDecoder().decode(PokemonDict.self, from: pokemonData)
                completion(.success(pokemon))
            } catch {
                print("Encountered error when decoding the data:", error.localizedDescription)
                completion(.failure(.unableToDecode))
            }
        }.resume()
    }
    
    
    static func fetchImage(for pokemon: PokemonDict, completetion: @escaping (Result<UIImage, ResultError>) -> Void) {
        guard let imageURL = URL(string: pokemon.sprites.frontShiny) else {return}

        URLSession.shared.dataTask(with: imageURL) { data, _, error in
            if let error = error {
                print("There was an error", error.localizedDescription)
                completetion(.failure(.thrownError(error)))
            }
            guard let data = data else {
                return
            }
            guard let pokemonImage = UIImage(data: data) else { return }
            completetion(.success(pokemonImage))
        }.resume()
    }
}// end
