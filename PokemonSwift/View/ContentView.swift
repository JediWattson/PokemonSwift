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
        List(pokemonVM.pokemonList){pokemon in
            PokemonRow( nameLink: pokemon )
            .onAppear(perform: {
                if !self.pokemonVM.endOfList {
                    if self.pokemonVM.shouldLoadMore(item: pokemon){
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
