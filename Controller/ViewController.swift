//
//  ViewController.swift
//  Test_Pokedex
//
//  Created by Adrian Bello Cahuantzi on 31/08/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var arrayNames = [APIPokemon]()
    
var counter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        //Indica que el view controller implementa el delegado
        APIPokemonList.shared.delegatePokemonList = self
        //Invoca la funcion que realiza el consumo de servicio
        APIPokemonList.shared.doRequestList(counter: counter)
    }

    func loadMoreData(){
        counter += 20
        APIPokemonList.shared.doRequestList(counter: counter)
    }
    
    
    func setImage(pokedexid: Int) -> String {
        var imageURL = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(pokedexid).png"
        return imageURL
    }
}

extension ViewController: UITableViewDelegate {
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let obj = arrayNames[indexPath.item]
        let componentsUrl = obj.url.components(separatedBy: "/")
        let idPokemon = Int(componentsUrl[6]) ?? 1
        cell.imageView?.imageFromServerURL(urlString: setImage(pokedexid: idPokemon), PlaceHolderImage: UIImage (systemName: "circle.dashed")!)
        
        cell.textLabel?.text = "#\(idPokemon) \(obj.name)"
        cell.accessoryType = .disclosureIndicator
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "PokedexVC") as? PokedexVC {
            let urlString = arrayNames[indexPath.item].url
            
            let componentsUrl = urlString.components(separatedBy: "/")
            let idPokemon = Int(componentsUrl[6])
            vc.idPokemon = idPokemon ?? 1
            print(urlString)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == arrayNames.count - 1 {
            print("Fin de la tabla")
            self.loadMoreData()
        }
    }
}

extension ViewController: PokemonOutput {
    func succesResponseList(_ model: PokemonList) {
        
        DispatchQueue.main.async {
            if self.arrayNames.count == 0{
                self.arrayNames = model.results
            }else{
                model.results.forEach { (pokemon) in
                    self.arrayNames.append(pokemon)
                }                
            }
            
            self.tableView.reloadData()
        }
        
    }
    
    func failedResponseList(_ model: String) {
        
    }
}
