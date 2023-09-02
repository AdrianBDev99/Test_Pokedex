//
//  PokedexVC.swift
//  Test_Pokedex
//
//  Created by Adrian Bello Cahuantzi on 31/08/23.
//

import UIKit

class PokedexVC: UIViewController {

    @IBOutlet weak var mostrarPokemonUIButton: UIButton!
    
    @IBOutlet weak var imagenPokemon: UIImageView!
    
    @IBOutlet weak var pesoUILabel: UILabel!
    
    @IBOutlet weak var alturaUILabel: UILabel!
    
    @IBOutlet weak var viewFondo: UIView!
    
    
    @IBOutlet weak var viewFondoPA: UIView!
    
    
    @IBOutlet weak var idUILabel: UILabel!
    
    
    @IBOutlet weak var expUILabel: UILabel!
    
    var arrayNames = [PokedexModel]()
    var idPokemon = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        APIPokedex.shared.delegatePokedex = self
        //APIPokedex.shared.doRequest(pokemonid: Int.random(in: 1...1001))
        
        self.mostrarPokemonUIButton.layer.cornerRadius = 10
        
        self.imagenPokemon.layer.borderColor = UIColor.lightGray.cgColor
        self.imagenPokemon.layer.masksToBounds = true
        self.imagenPokemon.contentMode = .scaleToFill
        self.imagenPokemon.layer.borderWidth = 2
        self.imagenPokemon.layer.cornerRadius = 15
        
        self.viewFondo.layer.borderColor = UIColor.lightGray.cgColor
        self.viewFondo.layer.masksToBounds = true
        self.viewFondo.contentMode = .scaleToFill
        self.viewFondo.layer.borderWidth = 3
        self.viewFondo.layer.cornerRadius = 15
        
        self.pesoUILabel.layer.masksToBounds = true
        self.pesoUILabel.layer.cornerRadius = 15
        self.alturaUILabel.layer.masksToBounds = true
        self.alturaUILabel.layer.cornerRadius = 15
        
        self.idUILabel.layer.masksToBounds = true
        self.idUILabel.layer.cornerRadius = 15
        
        self.expUILabel.layer.masksToBounds = true
        self.expUILabel.layer.cornerRadius = 15
        
        self.viewFondoPA.layer.masksToBounds = true
        self.viewFondoPA.layer.cornerRadius = 15
        APIPokedex.shared.doRequest(pokemonid: idPokemon)
        
      
    }
    
    func configView(_ model: PokedexModel ) {
        DispatchQueue.main.async {
            self.pesoUILabel.text = String(model.weight)
            self.alturaUILabel.text = String(model.height)
            self.fetchImage(urlImage: model.sprites.front_default)
            self.title = model.name
            self.idUILabel.text = String(model.id)
            self.expUILabel.text = String(model.base_experience)
            
        }
        
        
    }
    
    private func fetchImage(urlImage: String) {
        //get Data
        //converte the data to image
        //set to image to image view
        guard let url = URL(string: urlImage) else {
            return
        }
        let getDataTask = URLSession.shared.dataTask(with: url) { data, _,error in
            guard let data = data, error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                let sprite = UIImage(data: data)
                self.imagenPokemon.image = sprite
            }
        }
        getDataTask.resume()
    }

    @IBAction func mostrarPokemon(_ sender: Any) {
        APIPokedex.shared.doRequest(pokemonid: Int.random(in: 1...1001))
        
       
    }
    @IBAction func mostarListaPokemones(_ sender: Any) {
        
        let vc = UIStoryboard(name: "Main", bundle: nil)
        
        let controller = vc.instantiateViewController(identifier: "ViewController") as! ViewController
        
        UIApplication.shared.windows.first?.rootViewController = controller
        
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
}

extension PokedexVC: PokedexOutput {
    func succesPokedexResponse(_ model: PokedexModel) {
        self.configView(model)
    }
    
    func FailedResponse(_ message: String) {
    }
    
    
}
