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
    var indicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = []
    }
    
    func setupView(){
        // Setup UI Components
        self.navigationController?.isNavigationBarHidden = true
        indicator.backgroundColor = UIColor.gray.withAlphaComponent(0.2)
        indicator.frame = self.view.bounds
        self.view.addSubview(indicator)
        addNavBar()
        navBar.delegate = self
    }
    
    func setupNavBar(_ right: rightNavBar,_ left: leftNavBar,_ title: String){
        navBar.rightNavBar = right
        navBar.leftNavBar = left
        navBar.lbTitle.text = title
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
    
    func showIndicator(){
        indicator.startAnimating()
    }
    
    func hideIndicator(){
        indicator.stopAnimating()
    }
    
    func alert(title: String?, message: String?,
               isCancelable: Bool = false,
               handler: ((UIAlertAction) -> Swift.Void)? = nil) {
        
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        let action = UIAlertAction(title: "Ok", style: .default, handler: handler)
        alertVC.addAction(action)
        
        if isCancelable {
            let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: handler)
            alertVC.addAction(cancel)
        }
        self.present(alertVC, animated: true, completion: nil)
    }
}
extension BaseViewController: NavBarDelegate{
    func backPressed() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func menuPressed() {
        print("Menu")
    }
    
    func logoutPressed() {
        print("Logout")
        UserDefaults.standard.removeObject(forKey: "loggedIn")
        UserDefaults.standard.synchronize()
        backPressed()
    }
    
    
}
