//
//  JoinViewController.swift
//  Campfire
//
//  Created by Layne Johnson on 7/28/21.
//  Copyright © 2021. All rights reserved.

import UIKit
import Firebase

class JoinViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var joinButton: UIButton!
    @IBOutlet weak var notificationLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Notification label (validation/errors).
        notificationLabel.text = ""
        
        // Tap screen to dismiss keyboard.
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapGesture)
        
        // Delegates.
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        // Show navigation bar.
        navigationController?.isNavigationBarHidden = false
    }
    
    // MARK: - IBActions
    
    @IBAction func joinButtonPressed(_ sender: UIButton) {
    
        // Firebase create user.
        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    print(e.localizedDescription)
                    DispatchQueue.main.async {
                        // Print error in host language.
                        self.notificationLabel.text = e.localizedDescription
                    }
                } else {
                    print("User created successfully!")
                    DispatchQueue.main.async {
                        // Set notification label.
                        self.notificationLabel.text = "Welcome to Campfire! 👋"
                        // Segue to chat.
                        self.performSegue(withIdentifier: Constants.Segues.joinToChat, sender: self)
                    }
                }
            }
        }
    }
}

// MARK: - UITextFieldDelegate Extension

extension JoinViewController: UITextFieldDelegate {
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.placeholder = ""
    }
    
}
