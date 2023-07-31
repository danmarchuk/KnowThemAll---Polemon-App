//
//  Pokemon.swift
//  KnowThemAll
//
//  Created by Данік on 10/07/2023.
//

import Foundation

struct PokeModel: Codable, Equatable {
    var name: String?
    var ability: String?
    var height: Int?
    var weight: Int?
    var moves: String?
    var power: Int?
    var attack: String?
    var damage: Int?
    var imageUrl: String?
}
