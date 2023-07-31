//
//  PokeData.swift
//  KnowThemAll
//
//  Created by Данік on 11/07/2023.
//

import Foundation

struct PokeData: Codable, Equatable {
    let height: Int
    let weight: Int
    let moves: [Move]
    let abilities: [Ability]
    let stats: [Stat]
    let sprites: Sprites
    let name: String

    struct Move: Codable, Equatable {
        let move: MoveDetail
    }

    struct MoveDetail: Codable, Equatable {
        let name: String
    }

    struct Ability: Codable, Equatable {
        let ability: AbilityDetail
    }

    struct AbilityDetail: Codable, Equatable {
        let name: String
    }

    struct Stat: Codable, Equatable {
        let base_stat: Int
    }

    struct Sprites: Codable, Equatable {
        let versions: Versions
    }

    struct Versions: Codable, Equatable {
        let generationV: GenerationV

        enum CodingKeys: String, CodingKey {
            case generationV = "generation-v"
        }
    }

    struct GenerationV: Codable, Equatable {
        let blackWhite: BlackWhite

        enum CodingKeys: String, CodingKey {
            case blackWhite = "black-white"
        }
    }

    struct BlackWhite: Codable, Equatable {
        let animated: Animated
    }

    struct Animated: Codable, Equatable {
        let front_default: String
    }
}
