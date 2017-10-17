//
//  ImageHeaderCell.swift
//  SlideMenuControllerSwift
//
//  Created by Yuji Hato on 11/3/15.
//  Copyright © 2015 Yuji Hato. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift

protocol ImageHeaderViewDelegate: class {
    func goToSignIn()
    func goToFavorite()
    func goToUserProfile()
    func closeMenu()
}

class ImageHeaderView : UIView {
    
    @IBOutlet weak var boxView: UIView!
    @IBOutlet weak var profileImage : UIImageView!
    weak var delegate: ImageHeaderViewDelegate?
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var triangleView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor(hex: "E0E0E0")
        setupUI()
        updateUIByLogin()
        let usernameTapGesture = UITapGestureRecognizer(target: self, action: #selector(nameEmailLabelClicked))
        usernameLabel.addGestureRecognizer(usernameTapGesture)
        usernameLabel.isUserInteractionEnabled = true
        let emailTapGesture = UITapGestureRecognizer(target: self, action: #selector(nameEmailLabelClicked))
        emailLabel.addGestureRecognizer(emailTapGesture)
        emailLabel.isUserInteractionEnabled = true
    }
    
    func setupUI() {
        triangleView.transform = CGAffineTransform.identity.rotated(by: CGFloat(Double.pi/4))
    }
    
    @objc func nameEmailLabelClicked(_ sender: Any) {
        if Global.user == nil {
            delegate?.goToSignIn()
        } else {
            delegate?.goToUserProfile()
        }
    }
    
    func updateUIByLogin() {
        if Global.user != nil {
            boxView.isHidden = false
            self.frame.size.height = 205
            emailLabel.text = Global.user?.email
            usernameLabel.text = Global.user?.info?.name
        } else {
            usernameLabel.text = "WELCOME, USER."
            emailLabel.text = "Please sign in for more features."
            boxView.isHidden = true
            self.frame.size.height = 109
        }
    }
    
    @IBAction func favoriteButtonClicked(_ sender: Any) {
        delegate?.goToFavorite()
    }
    
    @IBAction func closeButtonClicked(_ sender: Any) {
        delegate?.closeMenu()
    }

    @IBAction func goToUserProfileButtonClicked(_ sender: Any) {
        nameEmailLabelClicked(sender)
    }
}
