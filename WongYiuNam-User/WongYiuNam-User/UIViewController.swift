//
//  UIViewControllerExtension.swift
//  SlideMenuControllerSwift
//
//  Created by Yuji Hato on 1/19/15.
//  Copyright (c) 2015 Yuji Hato. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func setNavigationBarItem() {
        self.addLeftBarButtonWithImage(UIImage(named: "ic_menu_black_24dp")!)
        
        let logoImageView = UIImageView(image: UIImage(named: "logo"))
        logoImageView.scale(f: 0.4)
        var view = UIView(frame: CGRect(x: 0, y: 0, width: 120, height: 80))
        view.addSubview(logoImageView)
        logoImageView.frame = CGRect(x: -65, y: 15, width: logoImageView.frame.width, height: logoImageView.frame.height)
    
        self.navigationItem.titleView = view
        view = UIView(frame: CGRect(x: 0, y: 0, width: 120, height: 80))
        let loginImageView = UIImageView(image: UIImage(named: "nav-login"))
        loginImageView.scale(f: 0.2)
        loginImageView.frame = CGRect(x: 40, y: 25, width: loginImageView.frame.width, height: loginImageView.frame.height)
        let label = UILabel(frame: CGRect(x: 75, y: 0, width: 120, height: 80))
        label.text = "Login"
        view.addSubview(loginImageView)
        view.addSubview(label)
        let rightBarButtonItemClicked = UITapGestureRecognizer(target: self, action: #selector(loginBarButtonItemClicked))
        view.addGestureRecognizer(rightBarButtonItemClicked)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: view)
        
        self.slideMenuController()?.removeLeftGestures()
        self.slideMenuController()?.addLeftGestures()
    }
    
    func loginBarButtonItemClicked() {
        
    }
    
    func removeNavigationBarItem() {
        self.navigationItem.leftBarButtonItem = nil
        self.slideMenuController()?.removeLeftGestures()
    }
}
