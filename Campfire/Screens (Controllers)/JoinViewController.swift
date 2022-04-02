//
//  JoinViewController.swift
//  Campfire
//
//  Created by Layne Johnson on 7/28/21.
//  Copyright © 2021. All rights reserved.

import UIKit
import Firebase
import FirebaseAuth

class JoinViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var joinButton: UIButton!
    @IBOutlet weak var notificationLabel: UILabel!
    @IBOutlet weak var notificationLabelLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var notificationLabelTrailingConstraint: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Notification label (validation/errors).
        notificationLabel.text = "Enter an email address and password to join Campfire ⛺️"
        notificationLabel.textColor = UIColor(named: "Tuatara")
        
        // Tap screen to dismiss keyboard.
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapGesture)
        
        // Set delegates.
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        // Configure UI.
        joinButton.styleButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        // Show navigation bar.
        navigationController?.isNavigationBarHidden = false
    }
    
    // MARK: - IBActions
    
    @IBAction func joinButtonPressed(_ sender: UIButton?) {
        
        if let email = emailTextField.text, let password = passwordTextField.text {
            
            // Firebase create user.
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let error = error, let errorCode = AuthErrorCode(rawValue: error._code) {
                    print(error)
                    print(error.localizedDescription)
                    
                    // Handle error.
                    self.handleError(errorCode: errorCode)
                    
                } else {
                    print("User created successfully!")
                    
                    // Set notification label.
                    DispatchQueue.main.async {
                        self.notificationLabel.text = "Welcome to Campfire! 👋"
                        self.notificationLabel.font = .systemFont(ofSize: 30, weight: .bold)
                        self.notificationLabel.textColor = UIColor(named: "Tuatara")

                        // Set label constraints.
                        self.notificationLabelLeadingConstraint.constant = 50
                        self.notificationLabelTrailingConstraint.constant = 50
                        self.view.layoutIfNeeded()
                    }
                    
                    // Segue to chat view.
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
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
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        // Try to find next responder
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            // Not found, so remove keyboard.
            textField.resignFirstResponder()
            joinButtonPressed(nil)
        }
        return false
    }
    
}

// MARK: - Error Handling

extension JoinViewController {
    
    func handleError(errorCode: AuthErrorCode) {
        print("This is the error handling function.")
        
        if emailTextField.text == "" && passwordTextField.text == "" {
            DispatchQueue.main.async { [self] in
                self.notificationLabel.text = "Please enter an email address and password to join Campfire ⛺️"
                self.notificationLabel.textColor = UIColor(named: "Campfire")
            }
            
        } else {
            
            // Set notification label color.
            self.notificationLabel.textColor = UIColor(named: "Campfire")
            
            switch errorCode {
                
            case .invalidCredential:
                DispatchQueue.main.async {
                    self.notificationLabel.text = "Please check email/password combination."
                }
            case .emailAlreadyInUse:
                DispatchQueue.main.async {
                    self.notificationLabel.text = "That email address is already in use."
                }
            case .invalidEmail:
                DispatchQueue.main.async {
                    self.notificationLabel.text = "Please enter a valid email address."
                }
            case .userNotFound:
                DispatchQueue.main.async {
                    self.notificationLabel.text = "Cannot find user."
                }
            case .credentialAlreadyInUse:
                DispatchQueue.main.async {
                    self.notificationLabel.text = "Credential already in use."
                }
            case .weakPassword:
                DispatchQueue.main.async {
                    self.notificationLabel.text = "Password must be 6 characters long or more."
                }
            case .missingEmail:
                DispatchQueue.main.async {
                    self.notificationLabel.text = "Please enter a valid email address."
                }
            case .unverifiedEmail:
                DispatchQueue.main.async {
                    self.notificationLabel.text = "Please verify your email address."
                }
            default:
                DispatchQueue.main.async {
                    self.notificationLabel.text = "Please enter an email address and password to join Campfire ⛺️"
                }
            }
        }
    }
}
