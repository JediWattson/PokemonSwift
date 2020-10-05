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

    func fetchList(){
        guard case let .ready(page) = pageStatus else {return}
        pageStatus = .loading(page: page)
        
        NetworkManager.shared.fetchList(nextPage){ result in
            switch result {
            case .success(let list):
                DispatchQueue.main.async {
                    self.nextPage = list.next ?? self.nextPage
                    self.previousPage = list.previous ?? self.previousPage
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
    
}
