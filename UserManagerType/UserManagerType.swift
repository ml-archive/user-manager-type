//
//  UserManager.swift
//  UserManagerType
//
//  Created by Jakob Mygind on 18/08/15.
//  Copyright © 2015 Nodes ApS. All rights reserved.
//

import Foundation
import Serializable
import Cashier

public let UserManagerCacheKey = "UserManager"

public protocol UserManagerType {
    associatedtype UserType: Serializable
}

public extension UserManagerType {

    ///  Get or set the current user object
    public static var currentUser: UserType? {
        get {
            // Retrieve object from cache
            return NOPersistentStore.cacheWithId(UserManagerCacheKey).serializableForKey("User")
        }
        set {
            if let newValue = newValue {
                // If there is a new value, set it
                NOPersistentStore.cacheWithId(UserManagerCacheKey).setSerializable(newValue, forKey: "User")
            } else {
                // Otherwise delete from cache
                NOPersistentStore.cacheWithId(UserManagerCacheKey).setObject(nil, forKey: "User")
            }
        }
    }

    /// Get or set the token string
    public static var token: String? {
        get {
            return NOPersistentStore.cacheWithId(UserManagerCacheKey).objectForKey("Token") as? String
        }
        set {
            NOPersistentStore.cacheWithId(UserManagerCacheKey).setObject(newValue, forKey: "Token")
        }
    }

    /// Logout current user and set the object with the key `User` to nil and optionally set token to nil.
    public static func logoutCurrentUser(clearToken clear: Bool) {
        if clear {
            token = nil
        }
        currentUser = nil
    }
    
    /**
     Check if someone is logged in by checking if a token is set.
     
     - Returns: `Boolean`
     */
    public static var isLoggedIn: Bool {
        guard let _ = token else { return false }
        return NOPersistentStore.cacheWithId(UserManagerCacheKey).objectForKeyIsValid("User")
    }
}
