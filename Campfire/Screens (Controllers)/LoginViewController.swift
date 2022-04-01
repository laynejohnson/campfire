//
//  LoginViewController.swift
//  Campfire
//
//  Created by Layne Johnson on 7/28/21.
//  Copyright © 2021. All rights reserved.

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var notificationLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Notification label (validation/errors).
        notificationLabel.text = "Enter an email address and password to login ⛺️"
        notificationLabel.textColor = UIColor(named: "Tuatara")
        
        // Tap screen to dismiss keyboard.
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapGesture)
        
        // Set delegates.
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        // Configure UI.
        loginButton.styleButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        // Show navigation bar.
        navigationController?.isNavigationBarHidden = false
    }
    
    // MARK: - IBActions
    
    @IBAction func loginButtonPressed(_ sender: UIButton?) {
        
        if let email = emailTextField.text, let password = passwordTextField.text {
            
            // Firebase authenticate user.
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let error = error, let errorCode = AuthErrorCode(rawValue: error._code) {
                    print(error)
                    print(error.localizedDescription)
                    
                    // Handle error.
                    self.handleError(errorCode: errorCode)
                    
                } else {
                    print("User logged in successfuly!")
                    
                    // Set notification label.
                    DispatchQueue.main.async {
                        self.notificationLabel.text = "Welcome back, friend! 👋"
                    }
                    
                    // Segue to chat view.
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
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
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        // Try to find next responder
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            // Not found, so remove keyboard.
            textField.resignFirstResponder()
            loginButtonPressed(nil)
        }
        return false
    }
    
}

// MARK: - Error Handling

extension LoginViewController {
    
    func handleError(errorCode: AuthErrorCode) {
        print("This is the error handling function.")
        
        if emailTextField.text == "" && passwordTextField.text == "" {
            DispatchQueue.main.async {
                self.notificationLabel.textColor = UIColor(named: "Campfire")
                self.notificationLabel.text = "Please enter an email address and password to login."
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
            case .wrongPassword:
                DispatchQueue.main.async {
                    self.notificationLabel.text = "Incorrect email or password."
                }
            case .userNotFound:
                DispatchQueue.main.async {
                    self.notificationLabel.text = "Hmmm...we can't seem to find that email address."
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
                    self.notificationLabel.text = "Please verify your email address and try again."
                }
            default:
                DispatchQueue.main.async {
                    self.notificationLabel.text = "Please enter an email address and password to login."
                }
            }
        }
    }
}
