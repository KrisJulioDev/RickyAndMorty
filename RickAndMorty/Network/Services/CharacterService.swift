//
//  CharacterService.swift
//  RickAndMorty
//
//  Created by Kris Julio on 12/27/22.
//

import Foundation
import Combine

struct CharacterService: HTTPRequestClient {
    private let scheme = "http"
    private let host = "rickandmortyapi.com"
    
    func request<T: Codable>(path: String, queries: [URLQueryItem]) -> AnyPublisher<T, Error> {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path
        components.queryItems = queries
        
        guard let url = components.url else {
            return Fail(error: APIError.invalidRequestError("URL Invalid"))
                .eraseToAnyPublisher()
        }
        
        return URLSession.shared
                .dataTaskPublisher(for: url)
                .map(\.data)
                .decode(type: T.self, decoder: JSONDecoder())
                .eraseToAnyPublisher()
    }
}
