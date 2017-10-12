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
}

class ImageHeaderView : UIView {
    
    @IBOutlet weak var boxView: UIView!
    @IBOutlet weak var profileImage : UIImageView!
    weak var delegate: ImageHeaderViewDelegate?
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor(hex: "E0E0E0")
//        self.profileImage.layoutIfNeeded()
//        self.profileImage.layer.cornerRadius = self.profileImage.bounds.size.height / 2
//        self.profileImage.clipsToBounds = true
//        self.profileImage.layer.borderWidth = 1
//        self.profileImage.layer.borderColor = UIColor.white.cgColor
        updateUIByLogin()
    }
    
    func updateUIByLogin() {
        if Global.user != nil {
            loginButton.isHidden = true
            usernameLabel.isHidden = false
            emailLabel.isHidden = false
            boxView.isHidden = false
            self.frame.size.height = 187
            emailLabel.text = Global.user?.email
            usernameLabel.text = Global.user?.info?.name
        } else {
            loginButton.isHidden = false
            usernameLabel.isHidden = true
            emailLabel.isHidden = true
            boxView.isHidden = true
            self.frame.size.height = 85
        }
    }
    
    @IBAction func favoriteButtonClicked(_ sender: Any) {
        delegate?.goToFavorite()
    }
    
    @IBAction func loginButtonClicked(_ sender: Any) {
        delegate?.goToSignIn()
    }
    
    @IBAction func goToUserProfileButtonClicked(_ sender: Any) {
        if Global.user != nil {
            delegate?.goToUserProfile()
        }
    }
}
