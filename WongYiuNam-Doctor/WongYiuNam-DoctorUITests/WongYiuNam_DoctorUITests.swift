//
//  WongYiuNam_DoctorUITests.swift
//  WongYiuNam-DoctorUITests
//
//  Created by Phat Chiem on 9/6/17.
//  Copyright © 2017 RTH. All rights reserved.
//

import XCTest

class WongYiuNam_DoctorUITests: XCTestCase {
        var app: XCUIApplication!
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
    app = XCUIApplication()

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
   app.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    // MARK: - Tests
    
    func testGoingThroughOnboarding() {
     
        
//        // Make sure we're displaying onboarding
//        XCTAssertTrue(app.isDisplayingOnboarding)
//
//        // Swipe left three times to go through the pages
//        app.swipeLeft()
//        app.swipeLeft()
//        app.swipeLeft()
//
//        // Tap the "Done" button
//        app.buttons["Done"].tap()
//
//        // Onboarding should no longer be displayed
//        XCTAssertFalse(app.isDisplayingOnboarding)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    func testLogin() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        


        let emailAddressTextField = app.textFields["Email address"]
        emailAddressTextField.tap()
        emailAddressTextField.typeText("rogelio78@hotmail.com")
        
//        let moreKey = app/*@START_MENU_TOKEN@*/.keys["more"]/*[[".keyboards",".keys[\"thêm, số\"]",".keys[\"more\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/
//        moreKey.tap()
//        moreKey.tap()
//        emailAddressTextField.typeText("78@")
//        
//        let moreKey2 = app/*@START_MENU_TOKEN@*/.keys["more"]/*[[".keyboards",".keys[\"thêm, thư\"]",".keys[\"more\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/
//        moreKey2.tap()
//        moreKey2.tap()
//        emailAddressTextField.typeText("hotmail")
//        moreKey.tap()
//        moreKey.tap()
//        emailAddressTextField.typeText(".")
//        moreKey2.tap()
//        moreKey2.tap()
//        emailAddressTextField.typeText("com")
        
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
