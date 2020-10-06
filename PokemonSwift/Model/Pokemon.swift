//
//  Pokemon.swift
//  PokemonSwift
//
//  Created by Field Employee on 10/5/20.
//  Copyright © 2020 JediWattson. All rights reserved.
//

import UIKit

struct PokemonList: Codable {
    var count: Int
    var next: String?
    var previous: String?
    var results: [NameLink]
    
    enum codingKeys: String, CodingKey {
        case count, next, previous, results
    }
}

struct Pokemon: Codable {
    var id: Int
    var name: String
    var image: UIImage?
    var types: [Types]
    var abilities: [Ability]
    var moves: [Move]
    var sprites: Sprites
    
    enum CodingKeys: String, CodingKey {
        case id, name, abilities, moves, sprites, types
    }
}

struct Sprites: Codable {
    var frontDefault: String?
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}

struct Types: Codable {
    var type: NameLink
    enum CodingKeys: String, CodingKey {
        case type
    }
}

struct Ability: Codable, Identifiable {
    var id = UUID()
    
    var ability: NameLink
    enum CodingKeys: String, CodingKey {
        case ability
    }
}

struct Move: Codable, Identifiable {
    var id = UUID()
    
    var move: NameLink
    enum CodingKeys: String, CodingKey {
        case move
    }
}

struct NameLink: Codable, Identifiable {
    var id = UUID()
    
    var name: String
    var url: String
    
    enum CodingKeys: String, CodingKey{
        case name, url
    }
}
