//
//  ChatViewController.swift
//  Campfire
//
//  Created by Layne Johnson on 7/28/21.
//  Copyright © 2021. All rights reserved.

import Foundation
import UIKit
import Firebase

 // TODO: Send should scroll view to top
 // TODO: Add choose your avatar
 // TODO: Send icon inside of text field

class ChatViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    
    // Initialize database.
    let db = Firestore.firestore()
    
    // Test messages.
    var messages: [Message] = [
        
        Message(sender: Constants.chatter1, body: "Hey guys!"),
        Message(sender: Constants.chatter2, body: "Should I bring the marshmallows??"),
        Message(sender: Constants.chatter1, body: "Yaaaas 👏"),
        Message(sender: Constants.chatter3, body: "I'll bring the firewood!"),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = Constants.appName
        navigationItem.hidesBackButton = true
        
        // Set current class as delegate for text field.
        messageTextField.delegate = self
        
        // Set current class as delegate for table view.
        tableView.dataSource = self
        
        // Register message cell nib.
        tableView.register(UINib(nibName: Constants.cellNibName, bundle: nil), forCellReuseIdentifier: Constants.cellIdentifier)
        
        // Retrieve messages from Firestore.
        loadMessages()
    }
    
    // MARK: - Load Firestore
    
    func loadMessages() {
        
        // Listen for Firestore updates.
        db.collection(Constants.FStore.collectionName)
            .order(by: Constants.FStore.dateField)
            .addSnapshotListener { querySnapshot, error in
                
                self.messages = []
                
                if let error = error {
                    print("There was a problem retrieving data from Firestore: \(error)")
                    
                } else {
                    if let snapshotDocuments = querySnapshot?.documents {
                        
                        for doc in snapshotDocuments {
                            
                            let data = doc.data()
                            if let sender = data[Constants.FStore.senderField] as? String, let messageBody = data[Constants.FStore.bodyField] as? String {
                                let newMessage = Message(sender: sender, body: messageBody)
                                self.messages.append(newMessage)
                                
                                // Update UI.
                                DispatchQueue.main.async {
                                    self.tableView.reloadData()
                                    let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                                    self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                                }
                            }
                        }
                    }
                }
            }
    }
    
    // MARK: - IBActions
    
    @IBAction func logOutButtonPressed(_ sender: UIBarButtonItem) {
        
        let firebaseAuth = Auth.auth()
        
        do {
            try firebaseAuth.signOut()
            navigationController?.popToRootViewController(animated: true)
            
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
    
    @IBAction func sendButtonPressed(_ sender: Any) {
        
        if let messageBody = messageTextField.text, let messageSender = Auth.auth().currentUser?.email {
            
            db.collection(Constants.FStore.collectionName).addDocument(data: [
                Constants.FStore.senderField: messageSender,
                Constants.FStore.bodyField: messageBody,
                Constants.FStore.dateField: Date().timeIntervalSince1970
            ]) { (error) in
                if let e = error {
                    print("There was a problem saving data to Firestore: \(e)")
                    
                } else {
                    print("Data saved successfully")
                    
                   // Update UI.
                    DispatchQueue.main.async {
                        self.messageTextField.text = ""
                        let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                        self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
                    }
                }
            }
        }
    }
}

// MARK: - UITableViewDataSource Extension

extension ChatViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return messages.count
    }
    
    // This method gets called for number messages.count
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let message = messages[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as! MessageCell
        cell.bubbleLabel.textColor = UIColor.black
        cell.bubbleLabel.text = message.body
        
        // This is a message from the current user.
        if message.sender == Auth.auth().currentUser?.email {
            
            cell.receiverAvatar.isHidden = true
            cell.senderAvatar.isHidden = false
            
        } else {
            
            // This is a message from another sender.
            cell.receiverAvatar.isHidden = false
            cell.senderAvatar.isHidden = true
        }
        return cell
    }
}

// MARK: - UITextField Extension

extension ChatViewController: UITextFieldDelegate {

}
