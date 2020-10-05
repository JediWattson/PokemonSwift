//
//  ContentView.swift
//  PokemonSwift
//
//  Created by Field Employee on 10/5/20.
//  Copyright © 2020 JediWattson. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var pokemonVM = ListViewModel()
    
    var body: some View {
        List(pokemonVM.pokemonList){pokemonNL in            
            PokemonRow( pokemon:  self.pokemonVM.pokemonDict[pokemonNL.name] )
                .onAppear(perform: {
                    if self.pokemonVM.pokemonDict[pokemonNL.name] == nil {
                        self.pokemonVM.fetchPokemon(pokemonNL)
                    }
                    if !self.pokemonVM.endOfList {
                        if self.pokemonVM.shouldLoadMore(item: pokemonNL){
                            self.pokemonVM.fetchList()
                        }
                    }
                })
        }
        .onAppear(perform: self.pokemonVM.fetchList)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
