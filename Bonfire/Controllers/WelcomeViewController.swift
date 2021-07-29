//
//  WelcomeViewController.swift
//  Bonfire
//
//  Created by Layne Johnson on 7/28/21.
//  Copyright © 2021. All rights reserved.

// MARK: - Development List:

// ---------------------------------- //
// - - - - - - - - DEV - - - - - - -  //
// ---------------------------------- //

 // TODO: Add ember animation

import UIKit

class WelcomeViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    // ---------------------------------- //
    // - - - - - - -  OUTLETS - - - - - - //
    // ---------------------------------- //
    
    @IBOutlet weak var bonfireImage: UIImageView!
    @IBOutlet weak var bonfireLabel: UILabel!
    @IBOutlet weak var joinButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    // MARK: - Variables
    
    // ---------------------------------- //
    // - - - - - - - - VARS - - - - - - - //
    // ---------------------------------- //

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Text animation
        bonfireLabel.text = ""
        
        var charIndex = 0.0
        let titleText = "Bonfire"
        for letter in titleText {
            Timer.scheduledTimer(withTimeInterval: 0.1 * charIndex, repeats: false) { (timer) in
                self.bonfireLabel.text?.append(letter)
            
            }
            charIndex += 1
        }
    } // End viewDidLoad


}

