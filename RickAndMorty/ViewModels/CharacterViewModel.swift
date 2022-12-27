//
//  CharacterViewModel.swift
//  RickAndMorty
//
//  Created by Kris Julio on 12/27/22.
//

import Foundation
import Combine
import SwiftUI
import CachedAsyncImage
import RealmSwift

class CharacterViewModel: ObservableObject {
    private var cancellables: [AnyCancellable] = [] 
    let character: Character
    let key = "FAVOURITES"
    
    internal init(character: Character) {
        self.character = character
    }
    
    func addToFavourite() {
        let id = character.id
        
        let realm = try! Realm()
        let char = realm.object(ofType: Character.self, forPrimaryKey: id)
        do {
            try realm.write {
                char?.isFavourite = true
            }
        } catch let error as NSError {
            debugPrint("Error writing \(error)")
        }
    }
    
    func removeToFavourite() {
        let id = character.id
        
        let realm = try! Realm()
        let char = realm.object(ofType: Character.self, forPrimaryKey: id)
        do {
            try realm.write {
                char?.isFavourite = false
            }
        } catch let error as NSError {
            debugPrint("Error writing \(error)")
        }
    }
}
