//
//  APIPokedex.swift
//  Test_Pokedex
//
//  Created by Adrian Bello Cahuantzi on 31/08/23.
//

import Foundation

protocol  PokedexOutput: AnyObject {
    func succesPokedexResponse(_ model: PokedexModel)
    func FailedResponse(_ message: String)
}


class APIPokedex: NSObject {
    public static let shared = APIPokedex()
    private override init() {}
    var delegatePokedex: PokedexOutput?
    
    
    func doRequest(pokemonid: Int) {
        let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(pokemonid)")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: url) {
            data, response, error in
            if let data = data {
                if let itemStore = try?JSONDecoder().decode(PokedexModel.self, from: data) {
                    print(itemStore)
                    self.delegatePokedex?.succesPokedexResponse(itemStore)
                } else {
                    print("Invalid Response")
                    self.delegatePokedex?.FailedResponse("HTTP Request Failed \(error)")
                }
            }
        }
        task.resume()
    }
}
