//
//  ChatViewController.swift
//  Campfire
//
//  Created by Layne Johnson on 7/28/21.
//  Copyright © 2021. All rights reserved.

import Foundation
import UIKit
import Firebase

// TODO: Implement MessageKit: https://cocoapods.org/pods/MessageKit
// TODO: Add fire to nav bar
// TODO: Add choose avatar
// TODO: Add UI

class ChatViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    
    let db = Firestore.firestore()
    
    var messages: [Message] = [
        
        // Test messages
        //        Message(sender: Constants.testChatter1, body: "Hello, friend"),
        //        Message(sender: Constants.testChatter2, body: "Hello, dear friend")
        
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = Constants.appName
        navigationItem.hidesBackButton = true
        
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: Constants.cellNibName, bundle: nil), forCellReuseIdentifier: Constants.cellIdentifier)
        
        loadMessages()
    }
    
    func loadMessages() {
        
        // Listen for Firestore updates.
        db.collection(Constants.FStore.collectionName)
            .order(by: Constants.FStore.dateField)
            .addSnapshotListener { querySnapshot, error in
                
                self.messages = []
                
                if let e = error {
                    
                    print("There was a problem retrieving data from Firestore: \(e)")
                    
                } else {
                    
                    if let snapshotDocuments = querySnapshot?.documents {
                        for doc in snapshotDocuments {
                            let data = doc.data()
                            if let sender = data[Constants.FStore.senderField] as? String, let messageBody = data[Constants.FStore.bodyField] as? String {
                                let newMessage = Message(sender: sender, body: messageBody)
                                self.messages.append(newMessage)
                                
                                // Fetch main thread:
                                // Process happens in a closure (process happens in background); main thread must be fetched (process happening in foreground
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
                    // Use DispatchQueue to target main thread when inside closure.
                    DispatchQueue.main.async {
                        self.messageTextField.text = ""
                        let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                        self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
                    }
                }
            }
        }
    }
} // End ChatViewController

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
