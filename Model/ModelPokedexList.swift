//
//  ModelPokedexList.swift
//  Test_Pokedex
//
//  Created by Adrian Bello Cahuantzi on 01/09/23.
//

import Foundation

struct PokemonList: Decodable {
    let results: [APIPokemon]
}

struct APIPokemon: Decodable {
    let name: String
    let url: String
    
}
