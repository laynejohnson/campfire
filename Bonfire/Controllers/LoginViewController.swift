//
//  LoginViewController.swift
//  Bonfire
//
//  Created by Layne Johnson on 7/28/21.
//  Copyright © 2021. All rights reserved.

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
    }
    
    
    @IBAction func loginPressed(_ sender: UIButton) {
        
        if let email = emailField.text, let password = passwordField.text {
            
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
                guard let strongSelf = self else { return }
                
                if let e = error {
                    print(e.localizedDescription)
                    
                } else {
                    print("User logged in successfuly.")
                    self?.performSegue(withIdentifier: "LoginChat", sender: self)
                }
            }
            
        }
        
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
    
}
