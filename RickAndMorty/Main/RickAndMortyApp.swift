//
//  RickAndMortyApp.swift
//  RickAndMorty
//
//  Created by Kris Julio on 12/27/22.
//

import SwiftUI

@main
struct RickAndMortyApp: App {
    var body: some Scene {
        WindowGroup {
            let service = CharacterService()
            let viewModel = CharacterListViewModel(service: service)
            CharacterListView(viewModel: viewModel)
        }
    }
}
