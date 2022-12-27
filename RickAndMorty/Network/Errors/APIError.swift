//
//  APIError.swift
//  RickAndMorty
//
//  Created by Kris Julio on 12/27/22.
//

import Foundation

enum APIError: LocalizedError {
  /// Invalid request, e.g. invalid URL
  case invalidRequestError(String)
}
