//
//  ServiceModel.swift
//  PoliServices
//
//  Created by Raphael Augusto on 23/01/23.
//

import Foundation

// MARK: - Service model
struct Service: Codable {
    let success: Bool
    let data: [ServiceData]
}

// MARK: - ServiceData model
struct ServiceData: Codable {
    let id: Int
    let name: String
    let icon: String
    let color: String
    let duration: Int
}

