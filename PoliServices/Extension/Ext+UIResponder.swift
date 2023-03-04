//
//  Ext+UIResponder.swift
//  PoliServices
//
//  Created by Raphael Augusto on 25/02/23.
//

import Foundation
import UIKit

extension UIResponder {

    private struct Static {
        static weak var responder: UIResponder?
    }
    
    /// Finds the current first responder
    /// - Returns: the current UIResponder if it exists
    static func currentFirst() -> UIResponder? {
        Static.responder = nil
        UIApplication.shared.sendAction(#selector(UIResponder._trap), to: nil, from: nil, for: nil)
        return Static.responder
    }

    
    @objc private func _trap() {
        Static.responder = self
    }
}
