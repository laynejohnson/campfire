//
//  UIButton+Ext.swift
//  Campfire
//
//  Created by Layne Johnson on 3/30/22.
//

import Foundation
import UIKit

extension UIButton {
    
    func styleButton() {
        // Use auto layout.
        translatesAutoresizingMaskIntoConstraints = false

        // Button styling.
        self.layer.cornerRadius = 8
        self.backgroundColor = UIColor(named: "Jacarta")
        self.titleLabel?.textColor = UIColor(named: "CampfireWhite")
    
    }
}
