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
}

class ImageHeaderView : UIView {
    
    @IBOutlet weak var profileImage : UIImageView!
    @IBOutlet weak var backgroundImage : UIImageView!
    weak var delegate: ImageHeaderViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor(hex: "E0E0E0")
        self.profileImage.layoutIfNeeded()
        self.profileImage.layer.cornerRadius = self.profileImage.bounds.size.height / 2
        self.profileImage.clipsToBounds = true
        self.profileImage.layer.borderWidth = 1
        self.profileImage.layer.borderColor = UIColor.white.cgColor
        //self.profileImage.setRandomDownloadImage(80, height: 80)
        //self.backgroundImage.setRandomDownloadImage(Int(self.bounds.size.width), height: 160)
    }
    
    @IBAction func loginButtonClicked(_ sender: Any) {
        delegate?.goToSignIn()
//        let storyboard = UIStoryboard.init(name: "Login", bundle: nil)
//        let d = storyboard.instantiateViewController(withIdentifier: "signIn") as! SignInViewController
//        UIApplication.shared.keyWindow?.rootViewController?.show(d, sender: nil)
    }
}
