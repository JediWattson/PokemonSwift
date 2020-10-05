//
//  PokemonRow.swift
//  PokemonSwift
//
//  Created by Field Employee on 10/5/20.
//  Copyright © 2020 JediWattson. All rights reserved.
//

import SwiftUI

struct PokemonRow: View {
    var nameLink: NameLink
    @ObservedObject var pokemonVM = PokemonViewModel()
    
    var body: some View {
        HStack{
            Image(uiImage: pokemonVM.getImage())
                .resizable()
                .scaledToFit()
                .frame(width: 80.0, height: 80.0, alignment: .center)
            Spacer()
            VStack{
                Spacer()
                Text(pokemonVM.pokemon?.name ?? "MissingNo")
                    .multilineTextAlignment(.center)
                Spacer()
                HStack{
                    ForEach(pokemonVM.pokemon?.types ?? [], id: \.type.name){
                        Text($0.type.name)
                            .frame(width: 80.0, height: 30.0)
                            .foregroundColor(.white)
                            .background(TypeColors.colors[$0.type.name])
                            .cornerRadius(15.0)
                    }
                }
                Spacer()
            }
            Spacer()
            
        }
        .onAppear(perform: {
            self.pokemonVM.fetchPokemon(self.nameLink.url)
        })
    }    
}
