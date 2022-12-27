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

class CharacterViewModel: ObservableObject {
    private var cancellables: [AnyCancellable] = [] 
    let character: Character
    let key = "FAVOURITES"
    
    internal init(character: Character) {
        self.character = character
    }
    
    func addToFavourite() {
        let id = character.id
        var favourites = UserDefaults.standard.array(forKey: key) ?? []
        favourites.append(id)
        UserDefaults.standard.set(favourites, forKey: key)
    }
    
    func removeToFavourite() {
        let id = character.id
        var favourites = UserDefaults.standard.array(forKey: key) as? [Int]
        favourites = favourites?.filter { $0 != id }
        UserDefaults.standard.set(favourites, forKey: key)
    }
}
