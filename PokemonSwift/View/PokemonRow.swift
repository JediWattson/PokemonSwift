//
//  PokemonRow.swift
//  PokemonSwift
//
//  Created by Field Employee on 10/5/20.
//  Copyright © 2020 JediWattson. All rights reserved.
//

import SwiftUI

struct PokemonRow: View {
    var pokemon: Pokemon?
    
    var body: some View {
        HStack{
            Image(uiImage: getImage())
                .resizable()
                .scaledToFit()
                .frame(width: 80.0, height: 80.0, alignment: .center)
            Spacer()
            VStack{
                Spacer()
                Text(pokemon?.name.capitalized ?? "MissingNo")
                    .multilineTextAlignment(.center)
                    .font(Font.custom("PokemonHollowNormal", size: 22))
                Spacer()
                HStack{
                    ForEach(pokemon?.types ?? [], id: \.type.name){
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
    }
    
    func getImage() -> UIImage {
        guard let img = UIImage(named: "MissingNo.") else {
            fatalError("NO IMAGE")
        }
        return pokemon?.image ?? img
    }

}
