//
//  Ext+String.swift
//  PoliServices
//
//  Created by Raphael Augusto on 10/02/23.
//

import UIKit

extension String {
    
    static func formatTime(totalMinutes: Int) -> String {
        let hours = totalMinutes / 60
        let minutes = totalMinutes % 60
        return String(format: "%02d:%02d", hours, minutes)
    }
}
