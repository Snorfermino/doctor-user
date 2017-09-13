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
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 120, height: 80))
        view.addSubview(logoImageView)
        logoImageView.frame = CGRect(x: -45, y: 15, width: logoImageView.frame.width, height: logoImageView.frame.height)
        let logoImageViewGesture = UITapGestureRecognizer(target: self, action: #selector(logoImageViewClicked))
        logoImageView.addGestureRecognizer(logoImageViewGesture)
        logoImageView.isUserInteractionEnabled = true
        
        self.navigationItem.titleView = view
        let rightView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 80))
        let loginImageView = UIImageView(image: UIImage(named: "nav-login"))
        loginImageView.scale(f: 0.2)
        loginImageView.frame = CGRect(x: 40, y: 25, width: loginImageView.frame.width, height: loginImageView.frame.height)
        let label = UILabel(frame: CGRect(x: 75, y: 0, width: 120, height: 80))
        label.text = "Login"
        rightView.addSubview(loginImageView)
        rightView.addSubview(label)
        let rightBarButtonItemGesture = UITapGestureRecognizer(target: self, action: #selector(loginBarButtonItemClicked))
        rightView.addGestureRecognizer(rightBarButtonItemGesture)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightView)
        
        self.slideMenuController()?.removeLeftGestures()
        self.slideMenuController()?.addLeftGestures()
    }
    
    func loginBarButtonItemClicked() {
        Global.logined = !Global.logined
        NotificationCenter.default.post(name: Notification.Name("UserLoginedNotification"), object: nil)
    }
    
    func logoImageViewClicked() {
        print("logoImageViewClicked")
    }
    
    func removeNavigationBarItem() {
        self.navigationItem.leftBarButtonItem = nil
        self.slideMenuController()?.removeLeftGestures()
    }
}
