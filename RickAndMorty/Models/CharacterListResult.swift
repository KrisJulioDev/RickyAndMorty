//
//  CharacterListResult.swift
//  RickAndMorty
//
//  Created by Kris Julio on 12/27/22.
//

import Foundation

// MARK: - CharactersResult
struct CharactersResult: Codable {
    let info: Info
    let results: [Character]
}

// MARK: - Info
struct Info: Codable {
    let count, pages: Int
    let next, prev: String?
}
