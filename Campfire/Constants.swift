//
//  Constants.swift
//  Campfire
//
//  Created by Layne Johnson on 7/31/21.
//

import Foundation

/* Instance versus Type Properties:
 
 **Instance properties**
 
        let instanceProperty = ""value"
 
    * Must initialize an instance of structure before accessing property:
     
        1. let Constants = Constants()
        2. print(Constants.instanceProperty)

 **Type properties**

        static let typeProperty = "value"
 
    * Static keyword changes an instance property to a type property. Property now directly associated and accessed with the constant data type (instead of an instance of the Constants data type. Property may be accessed without initializing an instance of struct:
 
        1. Constants.typeProperty
 */

struct Constants {
    
    static let appName = "Campfire"
    static let cellIdentifier = "ReusableCell"
    static let cellNibName = "MessageCell"

    static let testChatter1 = "hello@campfire.com"
    static let testChatter2 = "helloback@campfire.com"
    static let testPassword = "123456"
    
    struct Segues {
        
        static let navigationController = "ToNavigationController"
        static let joinSegue = "Join"
        static let loginSegue = "Login"
    }
    
    struct FStore {
        
        static let collectionName = "messages"
        static let senderField = "sender"
        static let bodyField = "body"
        static let dateField = "date"
    }
}
