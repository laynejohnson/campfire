//
//  UIButton+Ext.swift
//  Campfire
//
//  Created by Layne Johnson on 3/30/22.
//

import UIKit

extension UIButton {
    
    func styleButton() {
        // Use auto layout.
        translatesAutoresizingMaskIntoConstraints = false

        // Button styling.
        self.layer.cornerRadius = 5
        self.backgroundColor = UIColor(named: "Jakarta")
        self.titleLabel?.textColor = UIColor(named: "White")
    }
}
