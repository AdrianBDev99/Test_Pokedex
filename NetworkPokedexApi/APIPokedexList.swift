//
//  APIPokedexList.swift
//  Test_Pokedex
//
//  Created by Adrian Bello Cahuantzi on 01/09/23.
//

import Foundation

protocol PokemonOutput: AnyObject {
    func succesResponseList(_ model: PokemonList)
    func failedResponseList(_ model: String)
    
}
    class APIPokemonList: NSObject {
        public static let shared = APIPokemonList()
        private override init() {}
        var delegatePokemonList: PokemonOutput?

        func doRequestList(counter: Int) {
    let url = URL(string: "https://pokeapi.co/api/v2/pokemon/?offset=\(counter)&limit=20")!
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    let task = URLSession.shared.dataTask(with: url) {
        data, response, error in
        if let data = data {
            if let itemStore = try? JSONDecoder().decode(PokemonList.self, from: data) {print(itemStore)
                self.delegatePokemonList?.succesResponseList(itemStore)
            } else {
                print("Invalid Response")
                self.delegatePokemonList?.failedResponseList("HTTP Request Failed \(error)")
            }
            }
        }
    task.resume()
    }
        
}
