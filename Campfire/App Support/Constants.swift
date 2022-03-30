//
//  Constants.swift
//  Campfire
//
//  Created by Layne Johnson on 7/31/21.
//

import Foundation

struct Constants {
    
    static let appName = "Campfire"
    static let cellIdentifier = "ReusableCell"
    static let cellNibName = "MessageCell"

    static let chatter1 = "hello@campfire.com"
    static let chatter2 = "helloo@campfire.com"
    static let chatter3 = "hellooo@campfire.com"
    static let testPassword = "123456"
    
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
