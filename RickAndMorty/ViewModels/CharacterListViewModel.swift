//
//  CharacterListViewModel.swift
//  RickAndMorty
//
//  Created by Kris Julio on 12/27/22.
//

import Foundation
import Combine
import RealmSwift
  
class CharacterListViewModel: ObservableObject {
    let service: CharacterService
    
    private var cancellables: [AnyCancellable] = []
    @Published var characters: [Character] = []
    
    internal init(service: CharacterService) {
        self.service = service
        self.setData()
    }
    
    private func setData() {
        fetchList()
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: RunLoop.main)
            .sink { error in
                debugPrint("error \(error)")
            } receiveValue: { [weak self] characters in
                guard let self else { return }
                self.characters = characters.results
                self.saveToRealm()
            }
            .store(in: &cancellables)
    }
    
    private func saveToRealm() {
        let realm = try! Realm()
        characters.forEach { character in
            do {
                try realm.write {
                    realm.add(character)
                }
            } catch let error as NSError {
                debugPrint("Error writing \(error)")
            }
        }
    }
    
    private func fetchList() -> AnyPublisher<CharactersResult, Error> {
        let queryItems = [URLQueryItem(name: "page", value: "1")]
        return service.request(path: Endpoint.characterAPI, queries: queryItems).eraseToAnyPublisher()
    }
}
