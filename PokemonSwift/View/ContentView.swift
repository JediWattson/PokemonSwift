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
        NavigationView{            
            List(pokemonVM.pokemonList){nameLink in
                NavigationLink(
                    destination: PokemonDetail(
                        pokemon: self.pokemonVM.getPokemon(nameLink.name)
                    )
                ){
                    PokemonRow(
                        pokemon: self.pokemonVM.getPokemon(nameLink.name)
                    )
                }
                .onAppear(perform: {
                    self.pokemonVM.handleAppear(pokemon: nameLink)
                })
            }
                .onAppear(perform: self.pokemonVM.fetchList)
                .navigationBarTitle("Pokemon!", displayMode: .inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
