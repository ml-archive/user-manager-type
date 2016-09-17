//
//  UserManagerTypeTests.swift
//  UserManagerTypeTests
//
//  Created by Chris Combs on 09/02/16.
//  Copyright © 2016 Nodes. All rights reserved.
//

import XCTest
@testable import UserManagerType

class UserManagerTypeTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
       UserManager.logoutCurrentUser(clearToken: true)
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testSaveAndReadUser() {
        let user = User()
        UserManager.currentUser = user
        let savedUser = UserManager.currentUser
        XCTAssertEqual(user, savedUser)
    }
    
    func testClearUserKeepToken() {
        UserManager.currentUser = User()
        let token = "123456789"
        UserManager.token = token
        UserManager.logoutCurrentUser(clearToken: false)
        XCTAssertEqual(token, UserManager.token)
        XCTAssertNil(UserManager.currentUser)
    }
    
    func testClearUserAndToken() {
        UserManager.currentUser = User()
        let token = "123456789"
        UserManager.token = token
        UserManager.logoutCurrentUser(clearToken: true)
        XCTAssertNil(UserManager.token)
        XCTAssertNil(UserManager.currentUser)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}


