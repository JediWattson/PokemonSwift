//
//  Pokemon.swift
//  PokemonSwift
//
//  Created by Field Employee on 10/5/20.
//  Copyright © 2020 JediWattson. All rights reserved.
//

import Foundation

class ListViewModel: ObservableObject {
    var limit = 25
    var nextPage: String = "https://pokeapi.co/api/v2/pokemon?offset=0&limit="
    var previousPage: String?
    
    @Published var pokemonList: [NameLink] = []

    func fetchList(){
        let url = "\(nextPage)\(limit)"
        NetworkManager.shared.fetchList(url){ result in
            switch result {
            case .success(let list):
                DispatchQueue.main.async {
                    self.nextPage = list.next ?? self.nextPage
                    self.previousPage = list.previous ?? self.previousPage
                    self.pokemonList.append(contentsOf: list.results)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
