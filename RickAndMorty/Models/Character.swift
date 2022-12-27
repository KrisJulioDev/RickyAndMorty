//
//  Character.swift
//  RickAndMorty
//
//  Created by Kris Julio on 12/27/22.
//

import Foundation
import RealmSwift

// MARK: - Result
class Character: Object, Codable, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id = 0
    @Persisted var name = ""
    @Persisted var status = ""
    @Persisted var species = ""
    @Persisted var type: String = ""
    @Persisted var gender: String = ""
    @Persisted var origin: Location?
    @Persisted var location: Location?
    @Persisted var image: String = ""
    @Persisted var url: String?
    @Persisted var created: String?
    @Persisted var isFavourite: Bool?
    
    convenience init(id: Int, name: String, status: String, species: String, type: String, gender: String, origin: Location, location: Location, image: String, url: String, created: String, isFavourite: Bool = false) {
        self.init()
        self.id = id
        self.name = name
        self.status = status
        self.species = species
        self.type = type
        self.gender = gender
        self.origin = origin
        self.location = location
        self.image = image
        self.url = url
        self.created = created
        self.isFavourite = isFavourite
    }
}

// MARK: - Location
class Location: Object, Codable {
    @Persisted var name: String = ""
    @Persisted var url: String = ""
}
