//
//  ChatViewController.swift
//  Bonfire
//
//  Created by Layne Johnson on 7/28/21.
//  Copyright © 2021. All rights reserved.

import Foundation
import UIKit
import Firebase

// TODO: Implement MessageKit: https://cocoapods.org/pods/MessageKit
// TODO: Add fire to nav bar

class ChatViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    
    var messages: [Message] = [
        Message(sender: Constants.testChatter1, body: "Good day friend!"),
        Message(sender: Constants.testChatter2, body: "Good day to you, my friend!"),
        Message(sender: Constants.testChatter1, body: "Shall we meet by the bonfire?")
    ]
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = Constants.appName
        navigationItem.hidesBackButton = true
        
        tableView.dataSource = self
        
        // Dismiss keyboard with tap gesture
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapGesture)

        // If gesture blocks other touches
        // tapGesture.cancelsTouchesInView = false
    }
    
    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
        
        let firebaseAuth = Auth.auth()
        
        do {
            try firebaseAuth.signOut()
            navigationController?.popToRootViewController(animated: true)
            
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
    
    
    @IBAction func sendPressed(_ sender: Any) {
        
    }
    
}

extension ChatViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath)
        
        cell.textLabel?.textColor = UIColor.black
        cell.textLabel?.text = "This is a cell"
        
        return cell
    }
    
    
}
