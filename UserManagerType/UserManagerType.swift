//
//  UserManager.swift
//  BorsenMobil
//
//  Created by Jakob Mygind on 18/08/15.
//  Copyright © 2015 Borsen. All rights reserved.
//

import Foundation

public protocol UserType : Serializable {
    
}


public protocol UserManagerType {}

public extension UserManagerType {
    
    /**
     Get the current user object.
     
     - Returns: Object that confroms with `UserType` with informations about the current user or `nil`.
    */
    public static func currentUser<T:UserType>() -> T? {
        return NOPersistentStore(id: "UserManager").serializableForKey("User")
    }
    
    /**
     Set the current user.
     
     - Parameter user: The user object that conforms `UserType`.
    */
    public static func setCurrentUser<T:UserType>(user:T) {
        NOPersistentStore(id: "UserManager").setSerializable(user, forKey: "User")
    }
    
    /// Logout current user and set the object with the key `User` to nil.
    public static func logoutCurrentUser() {
        NOPersistentStore(id: "UserManager").setObject(nil, forKey: "User")
    }
    
    /// Logout current user, call `logoutCurrentUser` and set token to nil.
    public static func logOutUserAndClearToken() {
        logoutCurrentUser()
        setToken(token: nil)
    }
    
    /**
     Set new user token.
     
     - Parameter token: Token as an optional `String`.
    */
    public static func setToken(token token:String?) {
         NOPersistentStore(id: "UserManager").setObject(token, forKey: "Token")
    }
    
    /**
     Get current user token.
     
     - Returns: Token as an optional `String`.
     */
    public static func token() -> String? {
        return NOPersistentStore(id: "UserManager").objectForKey("Token") as? String
    }
    
    /**
     Check if someone is logged in by checking if a token is set.
     
     - Returns: `Boolean`
     */
    public static func isLoggedIn() -> Bool {
        if !NOPersistentStore(id: "UserManager").objectForKeyIsValid("User") { return false }
        guard let _ = token() else { return false }
        return true
    }
}
