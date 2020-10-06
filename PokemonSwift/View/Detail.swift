//
//  Detail.swift
//  PokemonSwift
//
//  Created by Field Employee on 10/5/20.
//  Copyright © 2020 JediWattson. All rights reserved.
//

import SwiftUI

struct PokemonDetail: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
    var pokemon: Pokemon?
    
    var body: some View {
        Group{
            if verticalSizeClass == .regular {
                VStack(alignment: .center){
                    Text(pokemon?.name.capitalized ?? "MissingNo")
                        .multilineTextAlignment(.center)
                        .font(Font.custom("PokemonHollowNormal", size: 33))
                    Image(uiImage: getImage())
                        .resizable()
                        .scaledToFit()

                    HStack{
                        ForEach(pokemon?.types ?? [], id: \.type.name){
                            Text($0.type.name)
                                .frame(width: 80.0, height: 30.0)
                                .foregroundColor(.white)
                                .background(TypeColors.colors[$0.type.name])
                                .cornerRadius(15.0)
                        }
                    }
                    
                    Spacer().frame(height: 16)
                    
                    HStack{
                        VStack{
                            Text("Abilities")
                                .multilineTextAlignment(.center)

                            List(pokemon?.abilities ?? []){ability in
                                Text(ability.ability.name)
                            }
                        }
                        VStack{
                            Text("Moves")
                                .multilineTextAlignment(.center)

                            List(pokemon?.moves ?? []){move in
                                Text(move.move.name)
                            }
                        }

                    }
                }
            } else {
                HStack{
                    VStack{

                        Image(uiImage: getImage())
                           .resizable()
                           .scaledToFit()
                        Text(pokemon?.name.capitalized ?? "MissingNo")
                            .multilineTextAlignment(.center)
                            .font(Font.custom("PokemonHollowNormal", size: 33))
                        Spacer().frame(height: 8)

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
                    VStack{
                        Text("Abilities")
                            .multilineTextAlignment(.center)

                        List(pokemon?.abilities ?? []){ability in
                            Text(ability.ability.name)
                        }
                    }
                    VStack{
                        Text("Moves")
                            .multilineTextAlignment(.center)

                        List(pokemon?.moves ?? []){move in
                            Text(move.move.name)
                        }
                    }
                }
            }
        }
        .padding(8)
    }

    func getImage() -> UIImage {
        guard let img = UIImage(named: "MissingNo.") else {
            fatalError("NO IMAGE")
        }
        return pokemon?.image ?? img
    }

}
