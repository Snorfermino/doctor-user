//
//  WongYiuNam_UserTests.swift
//  WongYiuNam-UserTests
//
//  Created by Phat Chiem on 9/6/17.
//  Copyright © 2017 RTH. All rights reserved.
//

import XCTest
@testable import WongYiuNam_User

class WongYiuNam_UserTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testUpdateUserProfile() {
        var user = User()
        user.name = "ABC"
        user.email = "bb@gmail.com"
        let completion = {(result: String?) -> Void in
            print(result)
        }
        ApiManager.updateUserProfile(user: user, completion: completion)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
