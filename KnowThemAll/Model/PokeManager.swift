//
//  PokeManager.swift
//  KnowThemAll
//
//  Created by Данік on 10/07/2023.
//

import Foundation
import UIKit

protocol PokeManagerDelegate {
    func didUpdatePokemons(_ manager: PokeManager, pokemon: PokeModel)
    func didFailWithError(error: Error)
}

class PokeManager {
    let numberOfPokemons = 100
    let pokeUrl = "https://pokeapi.co/api/v2/pokemon/"
    
    var delegate: PokeManagerDelegate?
    let session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func fetchPokemons() {
        for index in 1...numberOfPokemons {
            let urlString = "\(pokeUrl)\(index)"
            performRequest(with: urlString)
        }
    }
    
    private func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let task = session.dataTask(with: url) { [weak self] data, response, error in
                if error != nil {
                    self?.delegate?.didFailWithError(error: error!)
                    return
                }
                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
                    let error = NSError(domain: "", code: httpResponse.statusCode, userInfo: nil)
                    self?.delegate?.didFailWithError(error: error)
                    return
                }
                if let safeData = data, let pokemon = self?.parseJSONToPokemon(safeData), let manager = self {
                    self?.delegate?.didUpdatePokemons(manager, pokemon: pokemon)
                }
            }
            task.resume()
        }
    }
    
    private func parseJSONToPokemon(_ data: Data) -> PokeModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(PokeData.self, from: data)
            let height = decodedData.height
            let weight = decodedData.weight
            let moves = decodedData.moves.first?.move.name
            let ability = "\(decodedData.abilities[0].ability.name)"
            let attack = decodedData.moves.first?.move.name
            let damage = decodedData.stats[1].base_stat
            let imageUrl = decodedData.sprites.versions.generationV.blackWhite.animated.front_default
            let pokemon = PokeModel(name: decodedData.name, ability: ability, height: height, weight: weight, moves: moves, power: damage, attack: attack, damage: damage, imageUrl: imageUrl)
            return pokemon
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
}
