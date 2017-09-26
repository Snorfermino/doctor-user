//
//  BaseViewController.swift
//  WongYiuNam-Doctor
//
//  Created by Admin on 9/12/17.
//  Copyright © 2017 RTH. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    @IBInspectable var isNavBarEnabled = false
    var navBar: NavBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = []
        addNavBar()
    }
    
    func setupView(){
        // Setup UI Components
    }
    
    func addNavBar(){
        let screenSize = UIScreen.main.bounds
        navBar = NavBar(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: 65))
        self.view.addSubview(navBar)
        navBar.translatesAutoresizingMaskIntoConstraints = false
        
        let horConstraint = NSLayoutConstraint(item: navBar, attribute: .centerX, relatedBy: .equal,
                                               toItem: view, attribute: .centerX,
                                               multiplier: 1.0, constant: 0.0)
        let verConstraint = NSLayoutConstraint(item: navBar, attribute: .top, relatedBy: .equal,
                                               toItem: view, attribute: .top,
                                               multiplier: 1.0, constant: 0.0)
        let widConstraint = NSLayoutConstraint(item: navBar, attribute: .width, relatedBy: .equal,
                                               toItem: view, attribute: .width,
                                               multiplier: 1.0, constant: 0.0)
        let heiConstraint = NSLayoutConstraint(item: navBar, attribute: .height, relatedBy: .equal,
                                               toItem: navBar, attribute: .width,
                                               multiplier: 65/375, constant: 0.0)
        let leadConstraint = NSLayoutConstraint(item: navBar, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: 0)
        let trailConstraint = NSLayoutConstraint(item: navBar, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1.0, constant: 0)
        self.view.addConstraints([horConstraint,verConstraint,widConstraint,heiConstraint,leadConstraint,trailConstraint])
    }
    
}
