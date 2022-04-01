//
//  LaunchScreenViewController.swift
//  Campfire
//
//  Created by Layne Johnson on 11/19/21.
//

import UIKit

class LaunchScreenViewController: UIViewController {
    
    // For launch screen animations:
    // Setup launch screen storyboard view and add animations here.
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        // Segue to navigation controller.
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.performSegue(withIdentifier: Constants.Segues.launchToWelcome, sender: self)
        }
    }
}
