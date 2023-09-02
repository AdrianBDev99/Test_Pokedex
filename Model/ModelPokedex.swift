//
//  ModelPokedex.swift
//  Test_Pokedex
//
//  Created by Adrian Bello Cahuantzi on 31/08/23.
//

import Foundation

struct PokedexList: Decodable {
    let results: [PokedexModel]
}

struct PokedexModel: Decodable {
    let name: String
    let height: Double
    let weight: Double
    let sprites: PokedexSprites
    let id: Int
    let base_experience: Int
}

struct PokedexSprites: Decodable {
    let front_default: String
}



