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
        
        configureButton(button: joinButton)
        configureButton(button: loginButton)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        // Hide navigation bar.
        navigationController?.isNavigationBarHidden = true
    }
    
    private func configureButton(button: UIButton) {
        button.layer.cornerRadius = 8
        button.backgroundColor = .systemIndigo
    }
    
    
}
