//
//  ChatViewController.swift
//  Bonfire
//
//  Created by Layne Johnson on 7/28/21.
//  Copyright © 2021. All rights reserved.

import UIKit

 // TODO: Implement MessageKit: https://cocoapods.org/pods/MessageKit
 // TODO: Implement signout

/*
    let firebaseAuth = Auth.auth()
 do {
   try firebaseAuth.signOut()
 } catch let signOutError as NSError {
   print("Error signing out: %@", signOutError)
 }
 
   */

class ChatViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func sendPressed(_ sender: Any) {
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
