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
        addLeftBarButtonWithImage(#imageLiteral(resourceName: "nav-menu"))
        navigationController?.navigationBar.setBackgroundImage(UIImage.from(color: UIColor(red: 246, green: 246, blue: 246)), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = false
        addLogoToTitleView()
        setRightBarButton()
        slideMenuController()?.removeLeftGestures()
        slideMenuController()?.addLeftGestures()
    }
    
    func setNavigationBarItemForBack() {
        let image = #imageLiteral(resourceName: "nav-back").withRenderingMode(.alwaysOriginal)
        let button = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(popViewController))
        navigationItem.setLeftBarButton(button, animated: true)
        addLogoToTitleView()
    }
    
    @objc func popViewController() {
        navigationController?.popViewController(animated: true)
    }
    
    func setRightBarButton() {
        if(Global.user == nil) {
            addRightBarButtonWithImage(#imageLiteral(resourceName: "nav-login"))
            navigationItem.rightBarButtonItem?.action = #selector(rightBarButtonItemClicked)
        } else {
            navigationItem.rightBarButtonItem = nil
        }
    }
    
    @objc func rightBarButtonItemClicked() {
        let loginStoryboard = UIStoryboard(name: "Login", bundle: nil)
        let signInViewController = loginStoryboard.instantiateViewController(withIdentifier: "SignInViewController") as! SignInViewController
        let temp = UINavigationController(rootViewController: signInViewController)
        slideMenuController()?.changeMainViewController(temp, close: true)
    }
    
    func addLogoToTitleView() {
        let logoImageView = UIImageView(image: UIImage(named: "logo"))
        logoImageView.scale(f: 0.4)
        let view = UIView(frame: CGRect(x: 0, y: 0, width: logoImageView.frame.width, height: logoImageView.frame.height))
        view.addSubview(logoImageView)
        logoImageView.center = view.center
        let logoImageViewGesture = UITapGestureRecognizer(target: self, action: #selector(logoImageViewClicked))
        logoImageView.addGestureRecognizer(logoImageViewGesture)
        logoImageView.isUserInteractionEnabled = true
        navigationItem.titleView = view
    }
    
    func loginBarButtonItemClicked() {
        let storyboard = UIStoryboard.init(name: "Login", bundle: nil)
        let d = storyboard.instantiateViewController(withIdentifier: "signIn") as! SignInViewController
        present(d, animated: true, completion: nil)
    }
    
    @objc func logoImageViewClicked() {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let homeViewController = mainStoryboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        let temp = UINavigationController(rootViewController: homeViewController)
        slideMenuController()?.changeMainViewController(temp, close: true)
    }
    
    func removeNavigationBarItem() {
        navigationItem.leftBarButtonItem = nil
        slideMenuController()?.removeLeftGestures()
    }
}
