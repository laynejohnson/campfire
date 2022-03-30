//
//  WelcomeViewController.swift
//  Campfire
//
//  Created by Layne Johnson on 7/28/21.
//  Copyright © 2021. All rights reserved.

import UIKit

class WelcomeViewController: UIViewController {
    
    @IBOutlet weak var campfireImage: UIImageView!
    @IBOutlet weak var joinButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        joinButton.styleButton()
        loginButton.styleButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        // Hide navigation bar.
        navigationController?.isNavigationBarHidden = true
    }
}
