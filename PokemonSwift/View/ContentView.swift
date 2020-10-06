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
            List(pokemonVM.pokemonList){pokemonNL in
                NavigationLink(
                    destination: PokemonDetail(
                        pokemon: self.pokemonVM.pokemonDict[pokemonNL.name]
                    )
                ){
                    PokemonRow( pokemon: self.pokemonVM.pokemonDict[pokemonNL.name] )
                }
                .onAppear(perform: {
                    self.pokemonVM.handleAppear(pokemon: pokemonNL)
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
