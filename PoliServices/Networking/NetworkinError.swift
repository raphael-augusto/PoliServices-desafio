//
//  NetworkinError.swift
//  PoliServices
//
//  Created by Raphael Augusto on 07/02/23.
//

import Foundation

enum NetworkinError: Error {
    case invalidURL
    case errorGeneric(description: String)
    case invalidResponse
    case invalidData
    case errorDecoder
}
