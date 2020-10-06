//
//  Pokemon.swift
//  PokemonSwift
//
//  Created by Field Employee on 10/5/20.
//  Copyright © 2020 JediWattson. All rights reserved.
//

import Foundation

class ListViewModel: ObservableObject {
    var nextPage: String = "https://pokeapi.co/api/v2/pokemon?offset=0&limit=25"
    var previousPage: String?
    
    
    var pageStatus = PageStatus.ready(nextPage: 0)
    
    @Published var endOfList = false
    @Published var pokemonList = [NameLink]()
    @Published var pokemonDict = [String: Pokemon]()
    
    func fetchList(){
        guard case let .ready(page) = pageStatus else {return}
        pageStatus = .loading(page: page)
        
        NetworkManager.shared.fetchList(nextPage){ result in
            switch result {
            case .success(let list):
                
                self.nextPage = list.next ?? self.nextPage
                self.previousPage = list.previous ?? self.previousPage

                DispatchQueue.main.async {
                    self.pokemonList.append(contentsOf: list.results)
                    if self.pokemonList.count > 149 {
                        self.pageStatus = .done
                        self.endOfList = true
                    } else {
                        self.pageStatus = .ready(nextPage: page+1)
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    func shouldLoadMore(item : NameLink) -> Bool{
        return item.id == pokemonList.last?.id
    }
    
    func fetchPokemon(_ fetch: NameLink){
        NetworkManager.shared.fetchPokemon(fetch.url){ result in
            switch result {
            case .success(let pokemon):
                DispatchQueue.main.async {
                    self.pokemonDict[fetch.name] = pokemon
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func handleAppear(pokemon: NameLink){
        if self.pokemonDict[pokemon.name] == nil {
            self.fetchPokemon(pokemon)
        }
        if !self.endOfList {
            if self.shouldLoadMore(item: pokemon){
                self.fetchList()
            }
        }
    }
    
    func getPokemon(_ pokemon: String) -> Pokemon? {
        return self.pokemonDict[pokemon]
    }
}
