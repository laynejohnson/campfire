//
//  WelcomeViewController.swift
//  Campfire
//
//  Created by Layne Johnson on 7/28/21.
//  Copyright © 2021. All rights reserved.

import UIKit

class WelcomeViewController: UIViewController {
    
    @IBOutlet weak var campfireImage: UIImageView!
    @IBOutlet weak var joinWelcomeButton: UIButton!
    @IBOutlet weak var loginWelcomeButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        // Hide navigation bar.
        navigationController?.isNavigationBarHidden = true
    }
}
