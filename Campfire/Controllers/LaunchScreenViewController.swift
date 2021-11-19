//
//  LaunchScreenViewController.swift
//  Campfire
//
//  Created by Layne Johnson on 11/19/21.
//

import UIKit

class LaunchScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        
        
        // Segue to navigation controller.
        performSegue(withIdentifier: Constants.Segues.navigationController, sender: self)
    }
    

}
