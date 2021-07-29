//
//  RegisterViewController.swift
//  Bonfire
//
//  Created by Layne Johnson on 7/28/21.
//

import UIKit

 // TODO: Add username pop-up

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var joinButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func joinPressed(_ sender: UIButton) {
        
         performSegue(withIdentifier: "joins", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }


}
