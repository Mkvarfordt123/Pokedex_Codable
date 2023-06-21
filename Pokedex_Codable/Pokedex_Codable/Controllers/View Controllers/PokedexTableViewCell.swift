//
//  PokedexTableViewCell.swift
//  Pokedex_Codable
//
//  Created by Milo Kvarfordt on 6/21/23.
//

import UIKit

class PokedexTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonIdLabel: UILabel!
    
    var pokemon: PokemonDict?
    var pokemonSprite: UIImage?
    
    // Methods
    func updateViews(pokemonResult: ResultDict ) {
        pokemonNameLabel.text = pokemonResult.name
        NetworkingController.fetchPokemon(with: pokemonResult.name) { [weak self] result in
            switch result {
            case .success(let pokemon):
                self?.pokemon = pokemon
                self?.fetchPokemonImage(pokemon: pokemon)
            case .failure(let error):
                print(error.errorDescription!)
            }
        }
    }
    func fetchPokemonImage(pokemon: PokemonDict) {
        NetworkingController.fetchImage(for: pokemon) { [weak self] result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self?.pokemonSprite = image
                    self?.pokemonIdLabel.text = "#\(pokemon.id)"
                    self?.pokemonNameLabel.text = pokemon.name
                    self?.pokemonImageView.image = image
                }
            case .failure(let failure):
                print(failure.errorDescription!)
            }
        }
        
    }
    
}
