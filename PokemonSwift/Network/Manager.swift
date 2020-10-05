//
//  Manager.swift
//  PokemonSwift
//
//  Created by Field Employee on 10/5/20.
//  Copyright © 2020 JediWattson. All rights reserved.
//

import UIKit

typealias ListHandler = (Result<PokemonList, NetworkError>) -> ()
typealias ImgHandler = (Result<UIImage, NetworkError>) -> ()
typealias PokemonTrainer = (Result<Pokemon, NetworkError>) -> ()

class NetworkManager {

    static let shared = NetworkManager()
    var session: URLSession
    var decoder: JSONDecoder
    var cache: NetworkCache

    private init(
        session: URLSession = URLSession.shared,
        cache: NetworkCache = NetworkCache.shared,
        decoder: JSONDecoder = JSONDecoder()
    ){
        self.session = session
        self.cache = cache
        self.decoder = decoder
    }
}

extension NetworkManager {
    func fetchList(_ url: String, completion: @escaping ListHandler){
        guard let url = URL(string: url) else { return }
        self.session.dataTask(with: url){ ( data, res, err) in
            if let err = err {
                print(err)
                return
            }
            
            guard let data = data else {
                print("NO DATA")
                return
            }
            
            do {
                let list = try self.decoder.decode(PokemonList.self, from: data)
                completion(.success(list))
            } catch {
                print(error)
                completion(.failure(.decodeError))
            }
            
        }.resume()
    }
    
    func decodePokemon(data: Data, completion: @escaping PokemonTrainer){
        do {
            var pokemon = try self.decoder.decode(Pokemon.self, from: data)
            guard let imageURL = pokemon.sprites.frontDefault else {
                completion(.failure(.badURL))
                return
            }
            self.fetchImage(imageURL){result in
                switch result {
                case .success(let image):
                    pokemon.image = image
                    completion(.success(pokemon))
                case .failure(let error):
                    completion(.failure(error))
                }
            }

        } catch {
            print(error)
            completion(.failure(.decodeError))
        }
        

    }
    
    func fetchPokemon(_ url: String, completion: @escaping PokemonTrainer){
        if let data = cache.get(url: url){
            self.decodePokemon(data: data, completion: completion)
            return
        }

        guard let urlObj = URL(string: url) else { return }
        self.session.dataTask(with: urlObj){ ( data, res, err) in
            if let err = err {
                print(err)
                return
            }
            
            guard let data = data else {
                print("NO DATA")
                return
            }
            
            self.cache.set(data: data, url: url)
            self.decodePokemon(data: data, completion: completion)
            
        }.resume()
    }
    
    func setImage(data: Data, completion: @escaping ImgHandler){
        guard let image = UIImage(data: data) else {
            completion(.failure(.badImage))
            return
        }
        completion(.success(image))
    }
    
    func fetchImage(_ url: String, completion: @escaping ImgHandler){
        if let data = cache.get(url: url){
            self.setImage(data: data, completion: completion)
        }

        guard let urlObj = URL(string: url) else { return }
        self.session.dataTask(with: urlObj){ ( data, res, err) in

            if let err = err {
                print(err)
                return
            }
            guard let data = data else {
                print("NO DATA")
                return
            }
            
            self.setImage(data: data, completion: completion)
            self.cache.set(data: data, url: url)
        }.resume()
    }
    
}
