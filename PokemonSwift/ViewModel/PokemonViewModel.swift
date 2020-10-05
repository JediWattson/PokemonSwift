//
//  PokemonViewModel.swift
//  PokemonSwift
//
//  Created by Field Employee on 10/5/20.
//  Copyright © 2020 JediWattson. All rights reserved.
//

import UIKit

class PokemonViewModel: ObservableObject {
    @Published var pokemon: Pokemon?
    
    func fetchPokemon(_ url: String){
        NetworkManager.shared.fetchPokemon(url){ result in
            switch result {
            case .success(let pokemon):
                DispatchQueue.main.async {
                    self.pokemon = pokemon
                }                
            case .failure(let error):
                print(error)
            }
        }
        
    }
    

   func getImage() -> UIImage {
       guard let img = UIImage(named: "MissingNo.") else {
           fatalError("NO IMAGE")
       }
       return pokemon?.image ?? img
   }

}
