//
//  DetailsModel.swift
//  PoliServices
//
//  Created by Raphael Augusto on 27/02/23.
//

import Foundation

// MARK: - WelcomeElement
struct DetailsElement: Decodable {
    let id: String
    var description: String
}

typealias Details = [DetailsElement]
