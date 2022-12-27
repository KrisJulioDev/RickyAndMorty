//
//  HTTPRequestClient.swift
//  RickAndMorty
//
//  Created by Kris Julio on 12/27/22.
//

import Foundation
import Combine

protocol HTTPRequestClient {
    func request<T: Codable>(path: String, queries: [URLQueryItem]) -> AnyPublisher<T, Error>
}
