//
//  JoinViewController.swift
//  Campfire
//
//  Created by Layne Johnson on 7/28/21.
//  Copyright © 2021. All rights reserved.

import UIKit
import Firebase

class JoinViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var joinButton: UIButton!
    @IBOutlet weak var guideLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guideLabel.text = ""
        
        // Dismiss keyboard with tap gesture
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapGesture)
        
        // If gesture blocks other touches
        //        tapGesture.cancelsTouchesInView = false
        
        // Set current class as text field delegate.
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        
    }
    
    // MARK: - UITextFieldDelegate Functions
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
      
        textField.placeholder = ""
    }
    
    // MARK: - IBActions
    
    @IBAction func joinPressed(_ sender: UIButton) {
        
        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    print(e.localizedDescription)
                    // localizedDescription prints error in host language
                    self.guideLabel.text = e.localizedDescription
                    
                } else {
                    self.performSegue(withIdentifier: Constants.Segues.joinSegue, sender: self)
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
}
