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
    
    var isEmailEntered: Bool {
        return emailTextField.text!.isEmpty
    }
    
    var isPasswordEntered: Bool {
        return passwordTextField.text!.isEmpty
    }
    
    
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
    
    // Move func once finished.
    func handleError(errorCode: AuthErrorCode, label: UILabel) {
        switch errorCode {
        case .invalidEmail:
            notificationLabel.text = "Please enter a valid email address."
        case .wrongPassword:
            notificationLabel.text = "Invalid email address or password."
        case .userNotFound:
            notificationLabel.text = "User not found. Try a different email address or sign up here."
        case .networkError:
            notificationLabel.text = "Network error"
        case .emailAlreadyInUse:
            notificationLabel.text = "That email address has already been registered."
        case .weakPassword:
            notificationLabel.text = "The password must be 6 characters long or more."
        case .missingEmail:
            notificationLabel.text = "Please enter a valid email address."
        case .sessionExpired:
            notificationLabel.text = "Session has expired."
        case .unverifiedEmail:
            notificationLabel.text = "Please check your inbox to verify your email address and try again."
        default:
            notificationLabel.text = "Please enter a valid email address and password to join Campfire."
        }
    }
    
    // MARK: - IBActions
    
    @IBAction func joinButtonPressed(_ sender: UIButton) {
        
        // If email and password fields are empty, display notification.
        if !emailTextField.hasText && !passwordTextField.hasText {
            print("Please enter a valid email address and password to join Campfire.")
            
            // Set notification label.
            DispatchQueue.main.async {
                self.notificationLabel.text = "Please enter a valid email address and password to join Campfire."
            }
        } else {
            // Create user.
            if let email = emailTextField.text, let password = passwordTextField.text {
                Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                    if let error = error, let errorCode = AuthErrorCode(rawValue: error._code) {
                        print(error)
                        print(errorCode)
                        // Handle error.
                        DispatchQueue.main.async {
                            self.handleError(errorCode: errorCode, label: self.notificationLabel)
                        }
                    } else {
                        print("User created successfully!")
                        
                        DispatchQueue.main.async {
                            // Set notification label.
                            self.notificationLabel.text = "Welcome to Campfire 👋"
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            // Segue to chat.
                            self.performSegue(withIdentifier: Constants.Segues.joinToChat, sender: self)
                        }
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
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        
        // Email and text field are valid.
        if emailTextField.text!.isValidEmail && passwordTextField.text!.isValidPassword {
            notificationLabel.text = "Email ✅ Password ✅ "
        }
        
        // Email text field validation.
        if textField == emailTextField {
            if emailTextField.text != nil && !emailTextField.text!.isValidEmail {
                print("Not a valid email address.")
                
                // Set notification label.
                notificationLabel.text = "Please enter a valid email address."
                
            } else if emailTextField.text != nil && emailTextField.text!.isValidEmail {
                notificationLabel.text = "Email ✅"
            }
        }
        
        // Password text field validation.
        if textField == passwordTextField {
            if passwordTextField.text != nil && !passwordTextField.text!.isValidPassword {
                print("Not a valid password.")
                
                // Set notification label.
                notificationLabel.text = "Please enter a valid password."
            }
        }
    }
}
