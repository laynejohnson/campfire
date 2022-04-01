//
//  Constants.swift
//  Campfire
//
//  Created by Layne Johnson on 7/31/21.
//

import Foundation
import UIKit

struct Constants {
    
    static let appName = "Campfire"
    
    // Custom views.
    static let cellIdentifier = "ReusableCell"
    static let cellNibName = "MessageCell"

    // Testing variables.
    static let chatter1 = "hello@campfire.com"
    static let chatter2 = "helloo@campfire.com"
    static let chatter3 = "hellooo@campfire.com"
    static let testPassword = "123456"
    
    struct Colors {
        
        static let jakarta = UIColor(named: "Jakarta")
        static let campfireWhite = UIColor(named: "CampfireWhite")
        static let tuatara = UIColor(named: "Tuatara")
        static let merlin = UIColor(named: "Merlin")
        static let smoke = UIColor(named: "Smoke")
        static let campfire = UIColor(named: "Campfire")
    }
    
    struct Segues {
        
        static let launchToWelcome = "ToWelcome"
        static let joinToChat = "Join"
        static let loginToChat = "Login"
    }
    
    struct FStore {
        
        static let collectionName = "messages"
        static let senderField = "sender"
        static let bodyField = "body"
        static let dateField = "date"
    }
}
