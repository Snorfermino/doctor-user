//
//  ProfileViewController.swift
//  WongYiuNam-Doctor
//
//  Created by Admin on 9/13/17.
//  Copyright © 2017 RTH. All rights reserved.
//

import UIKit
import SDWebImage
class ProfileViewController: BaseViewController {
    
    @IBOutlet weak var imageViewAvatar:UIImageView!
    @IBOutlet weak var lbName:UILabel!
    @IBOutlet weak var lbSpeciality:UILabel!
    @IBOutlet weak var lbQualifications:UILabel!
    @IBOutlet weak var btnAvailable:WYNCheckBox!
    @IBOutlet weak var lbEarned:UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
         setupView()
    }
    
    override func setupView() {
        super.setupView()
//        navBar.isHidden = true
        navBar.leftNavBar = .none
        navBar.rightNavBar = .logout

        let userProfile = UserLoginInfo.shared.userInfo
        
        imageViewAvatar.downloadImageAndCacheToMemory(userProfile.avatar, placeHolder: #imageLiteral(resourceName: "ic_logo"), needAuthen: false)
        lbName.text = userProfile.name!
        lbSpeciality.text = userProfile.speciality!
        lbQualifications.text = userProfile.qualifications!
        btnAvailable.isSelected = userProfile.online!
        let index = lbEarned.text!.range(of: "Amount Earned This Month: ")
        let earnText = lbEarned.text!.substring(with: index!)
        
        let attributeString = NSMutableAttributedString(string: earnText + userProfile.totalEarned!)
        
        attributeString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor(hex: 0xFF7878), range: NSRange(location:25,length:userProfile.totalEarned!.count + 1))

        lbEarned.attributedText = attributeString
    }
    
    @IBAction func answerQuestionsPressed(_ sender: UIButton){
        self.performSegue(withIdentifier: "PendingQuestionVC", sender: nil)
    }
    
    @IBAction func answerHistoryPressed(_ sender: UIButton){
        self.performSegue(withIdentifier: "AnswerHistoryVC", sender: nil)
    }

}
