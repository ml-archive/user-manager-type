//
//  User.swift
//  UserManagerType
//
//  Created by Jakob Mygind on 17/09/16.
//  Copyright © 2016 Nodes. All rights reserved.
//

import Serpent
import UserManagerType

struct UserManager: UserManagerType {
    typealias UserType = User
}

struct User {
    var id = 0
    var url = URL(string: "http://google.dk")!
    var color = "red"
    var car = Car()
}

extension User: Serializable {
    init(dictionary: NSDictionary?) {
        id    <== (self, dictionary, "id")
        url   <== (self, dictionary, "url")
        color <== (self, dictionary, "color")
        car  <== (self, dictionary, "user")
    }
    
    func encodableRepresentation() -> NSCoding {
        let dict = NSMutableDictionary()
        (dict, "id")    <== id
        (dict, "url")   <== url
        (dict, "color") <== color
        (dict, "user")  <== car
        return dict
    }
}

extension User: Equatable {
    static func ==(l:User, r:User) -> Bool {
        return l.id == r.id &&
         l.url == r.url &&
        l.color == r.color &&
        l.car == r.car
    }
}

struct Car {
    var id = 1
    var price = 4000.0
}

extension Car: Equatable {
    static func ==(l: Car, r: Car) -> Bool {
    return l.id == r.id &&
        l.price == r.price
    }
}

extension Car: Serializable {
    init(dictionary: NSDictionary?) {
        id    <== (self, dictionary, "id")
        price <== (self, dictionary, "price")
    }
    
    func encodableRepresentation() -> NSCoding {
        let dict = NSMutableDictionary()
        (dict, "id")    <== id
        (dict, "price") <== price
        return dict
    }
}
