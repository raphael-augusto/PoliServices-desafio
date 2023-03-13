//
//  SetupModel.swift
//  PoliServices
//
//  Created by Raphael Augusto on 13/02/23.
//

import Foundation

struct SetupData {
    var toCompleteService: String
    let hasService: Bool
    let createDate: String
    let serviceName: String
    let serviceColor: String
    let serviceDate: String
    let serviceIcon: String
}

struct SetupCancel {
    var startDate: String
    var startTime: String
    var closingDate: String
    var closingTime: String
    var createDate: String
    let serviceName: String
    let serviceColor: String
    let serviceDate: String
    let serviceIcon: String
}
