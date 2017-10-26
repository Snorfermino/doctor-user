//
//  WongYiuNam_DoctorUITests.swift
//  WongYiuNam-DoctorUITests
//
//  Created by Phat Chiem on 9/6/17.
//  Copyright © 2017 RTH. All rights reserved.
//

import XCTest

class WongYiuNam_DoctorUITests: XCTestCase {
    // TODO: fix issue why some tests failed
    var app: XCUIApplication!
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        app = XCUIApplication()
        
        app.launch()
        
    }
    
    // MARK: - Tests
    
    func testGoingThroughOnboarding() {
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    func testLogin() {
        let emailAddressTextField = app.textFields["Email address"]
        emailAddressTextField.tap()
        emailAddressTextField.typeText("rogelio78@hotmail.com")
        let passwordSecureTextField = app.secureTextFields["Password"]
        passwordSecureTextField.tap()
        passwordSecureTextField.typeText("12345")
        
        let element = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        element.tap()
        element.children(matching: .button).element.tap()
        app.buttons["img btnAnswer"].tap()
        app.alerts["Error"].buttons["Ok"].tap()
    }
    func testLogout(){
        let emailAddressTextField = app.textFields["Email address"]
        emailAddressTextField.tap()
        emailAddressTextField.typeText("rogelio")
        let moreKey = app/*@START_MENU_TOKEN@*/.keys["more"]/*[[".keyboards",".keys[\"thêm, số\"]",".keys[\"more\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/
        moreKey.tap()
        emailAddressTextField.typeText("78@")
        moreKey.tap()
        emailAddressTextField.typeText("hotmail")
        moreKey.tap()
        emailAddressTextField.typeText(".")
        moreKey.tap()
        emailAddressTextField.typeText("com")
        let passwordSecureTextField = app.secureTextFields["Password"]
        passwordSecureTextField.tap()
        passwordSecureTextField.typeText("12345")
        
        let element = XCUIApplication().children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        element.tap()
        element.children(matching: .button).element.tap()
        element.children(matching: .other).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.tap()
    }
}
