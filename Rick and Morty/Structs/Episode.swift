//
//  Episode.swift
//  Rick and Morty
//
//  Created by Egor Bazakin on 19.07.2024.
//

import Foundation

struct Episode: Identifiable, Codable {
    let id: Int
    let name: String
    let airDate: String
    let episode: String
    let characters: [String]
    let url: String
    let created: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case airDate = "air_date"
        case episode
        case characters
        case url
        case created
    }
}

struct EpisodeResponse: Codable {
    let results: [Episode]
}

