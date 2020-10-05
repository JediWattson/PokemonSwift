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
    
    private init(
        session: URLSession = URLSession.shared,
        decoder: JSONDecoder = JSONDecoder()
    ){
        self.session = session
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
            guard let data = data else { return }
            
            do {
                let list = try self.decoder.decode(PokemonList.self, from: data)
                completion(.success(list))
            } catch {
                print(error)
                completion(.failure(.decodeError))
            }
            
        }.resume()
    }
    
    func fetchPokemon(_ url: String, completion: @escaping PokemonTrainer){
        guard let url = URL(string: url) else { return }
        self.session.dataTask(with: url){ ( data, res, err) in

            if let err = err {
                print(err)
                return
            }
            guard let data = data else { return }
            
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
            
        }.resume()
    }
    
    func fetchImage(_ url: String, completion: @escaping ImgHandler){
        guard let url = URL(string: url) else { return }
        self.session.dataTask(with: url){ ( data, res, err) in

            if let err = err {
                print(err)
                return
            }
            guard let data = data else { return }
            
            guard let image = UIImage(data: data) else {
                completion(.failure(.badImage))
                return
            }
            completion(.success(image))
        }.resume()
    }
    
}
