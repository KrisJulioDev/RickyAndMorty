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
    private var page = 1
    
    @Published var characters: [Character] = []
    
    internal init(service: CharacterService) {
        self.service = service
        self.setData()
    }
    
    func loadMoreContentIfNeeded(item: Character) {
        let thresholdIndex = characters.index(characters.endIndex, offsetBy: -5)
        if characters.firstIndex(where: { $0.id == item.id }) == thresholdIndex {
            page = page + 1
            setData()
        }
    }
    
    private func setData() {
        fetchList()
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: RunLoop.main)
            .sink { error in 
            } receiveValue: { [weak self] characters in
                guard let self else { return }
                self.characters.append(contentsOf: characters.results)
                self.saveToRealm()
            }
            .store(in: &cancellables)
    }
    
    private func saveToRealm() {
        let realm = try! Realm()
        characters.forEach { character in
            do {
                try realm.write {
                    realm.add(character, update: .all)
                }
            } catch let error as NSError {
                debugPrint("Error writing \(error)")
            }
        }
    }
    
    private func fetchList() -> AnyPublisher<CharactersResult, Error> {
        let queryItems = [URLQueryItem(name: "page", value: "\(page)")]
        return service.request(path: Endpoint.characterAPI, queries: queryItems).eraseToAnyPublisher()
    }
}
