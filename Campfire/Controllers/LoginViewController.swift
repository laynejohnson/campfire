//
//  LoginViewController.swift
//  Campfire
//
//  Created by Layne Johnson on 7/28/21.
//  Copyright © 2021. All rights reserved.

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var guideMessage: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guideMessage.text = ""
        
        // Dismiss keyboard with tap gesture
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapGesture)
        
        // If gesture blocks other touches
        //        tapGesture.cancelsTouchesInView = false
        
    }
    
    @IBAction func loginPressed(_ sender: UIButton) {
        
        if let email = emailField.text, let password = passwordField.text {
            
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                // User account data lives in authResult
                
                if let e = error {
                    print(e.localizedDescription)
                    self.guideMessage.text = String(e.localizedDescription)
                } else {
                    print("User logged in successfuly.")
                    self.performSegue(withIdentifier: Constants.loginSegue, sender: self)
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
    
}
