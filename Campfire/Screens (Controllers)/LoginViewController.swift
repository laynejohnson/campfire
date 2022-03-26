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
    @IBOutlet weak var notificationLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Notification label (validation/errors).
        notificationLabel.text = ""
        
        // Tap screen to dismiss keyboard.
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapGesture)

        // Delegates.
        emailField.delegate = self
        passwordField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        // Show navigation bar.
        navigationController?.isNavigationBarHidden = false
    }
    

    

    
    // MARK: - IBActions
    
    @IBAction func loginPressed(_ sender: UIButton) {
        
        // Firebase authentication. User account data lives in authResult
        if let email = emailField.text, let password = passwordField.text {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    print(e.localizedDescription)
              
                    DispatchQueue.main.async {
                        // Set notification label.
                        self.notificationLabel.text = String(e.localizedDescription)
                    }
                } else {
                    print("User logged in successfuly.")
                
                    DispatchQueue.main.async {
                        // Set notification label.
                        self.notificationLabel.text = "Welcome back friend! 👋"
                        // Segue to chat screen.
                        self.performSegue(withIdentifier: Constants.Segues.loginToChat, sender: self)
                    }
                }
            }
        }
    }
}

// MARK: - UITextFieldDelegate Extension

extension LoginViewController: UITextFieldDelegate {
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.placeholder = ""
    }
    
}
