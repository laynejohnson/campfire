//
//  Constants.swift
//  Bonfire
//
//  Created by Layne Johnson on 7/31/21.
//

import Foundation

/*
 **Instance properties**
 
        let instanceProperty = ""value"
 
    * Must initialize an instance of structure before accessing property:
     
        let Constants = Constants()
        print(instanceProperty)

 **Type properties**

        static let typeProperty = "value"
 
    * Static keyword changes an instance property to a type property. Property now directly associated and accessed with the constant data type (instead of an instance of the Constants data type. Property may be accessed without initializing an instance of struct:
 
        Constants.typeProperty
 */

struct Constants {

    static let joinSegue = "JoinBonfire"
    static let loginSegue = "LoginBonfire"
}
