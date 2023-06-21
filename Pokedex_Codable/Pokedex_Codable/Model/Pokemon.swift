//
//  Pokemon.swift
//  Pokedex_Codable
//
//  Created by Karl Pfister on 2/7/22.
//

import Foundation

struct PokemonDict: Decodable {
    let abilities: [AbilityDict]
    let id: Int
    let moves: [MovesDict]
    let name: String
    let sprites: SpriteDict
    let weight: Int
}
struct AbilityDict: Decodable {
    let ability: Ability
}
struct Ability: Decodable {
    let name: String
    let url: String
}
struct MovesDict: Decodable {
    let move: Move
}
struct Move: Decodable {
    let name: String
    let url: String
}
struct SpriteDict: Decodable {
    private enum CodingKeys: String, CodingKey {
        case frontShiny = "front_shiny"
    }
    let frontShiny: String
}
