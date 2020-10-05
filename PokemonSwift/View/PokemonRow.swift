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
    var fetchPokemon: ( String, @escaping (Pokemon)->() )->()
    
    @State private var pokemon: Pokemon?
    
    
    
    var body: some View {
        HStack{
            Image(uiImage: self.getImage())
                .resizable()
                .scaledToFit()
                .frame(width: 60.0, height: 60.0, alignment: .center)
            Text(pokemon?.name ?? "MissingNo")
        }
        .onAppear(perform: loadData)
    }
    
    func getImage() -> UIImage {
        guard let img = UIImage(named: "MissingNo.") else {
            fatalError("NO IMAGE")
        }
        
        return pokemon?.image ?? img
    }
    
    func loadData(){
        fetchPokemon(nameLink.url){
            data in
            self.pokemon = data
        }
    }
    
}
