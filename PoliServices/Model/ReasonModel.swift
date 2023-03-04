//
//  ReasonModel.swift
//  PoliServices
//
//  Created by Raphael Augusto on 01/03/23.
//

import Foundation

struct CancelResponse: Decodable {
    let success: Bool
    let data: CancelData?
}

struct CancelData: Codable {
    let reason: String
}
