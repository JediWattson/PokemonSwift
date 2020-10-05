//
//  ContentView.swift
//  PokemonSwift
//
//  Created by Field Employee on 10/5/20.
//  Copyright © 2020 JediWattson. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    let pokemonVM = PokemonViewModel()
    
    @State private var pokemonList: [NameLink] = []
    
    var body: some View {
        List(pokemonList){pokemon in
            PokemonRow(
                nameLink: pokemon,
                fetchPokemon: self.pokemonVM.fetchPokemon
            )
        }
        .onAppear(perform: loadData)
    }
    func loadData(){
        self.pokemonVM.fetchList{ data in
            self.pokemonList.append(contentsOf: data)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
