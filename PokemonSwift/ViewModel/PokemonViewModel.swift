//
//  Pokemon.swift
//  PokemonSwift
//
//  Created by Field Employee on 10/5/20.
//  Copyright © 2020 JediWattson. All rights reserved.
//

import Foundation

class PokemonViewModel {
    var limit = 25
    var nextPage: String = "https://pokeapi.co/api/v2/pokemon?offset=0&limit="
    var previousPage: String?
    
    func fetchList(completion: @escaping ([NameLink])->()){
        let url = "\(nextPage)\(limit)"
        NetworkManager.shared.fetchList(url){ result in
            switch result {
            case .success(let list):
                self.nextPage = list.next ?? self.nextPage
                self.previousPage = list.previous ?? self.previousPage
                completion(list.results)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchPokemon(_ url: String, completion: @escaping (Pokemon)->()){
        NetworkManager.shared.fetchPokemon(url){ result in
            switch result {
            case .success(let pokemon):
                completion(pokemon)
            case .failure(let error):
                print(error)
            }
        }
    }
}
