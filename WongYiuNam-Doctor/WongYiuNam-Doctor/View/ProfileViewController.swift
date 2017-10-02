//
//  ProfileViewController.swift
//  WongYiuNam-Doctor
//
//  Created by Admin on 9/13/17.
//  Copyright © 2017 RTH. All rights reserved.
//

import UIKit

class ProfileViewController: BaseViewController {
    
    @IBOutlet weak var imageViewAvatar:UIImageView!
    @IBOutlet weak var lbName:UILabel!
    @IBOutlet weak var lbSpeciality:UILabel!
    @IBOutlet weak var lbQualifications:UILabel!
    @IBOutlet weak var btnAvailable:UIButton!
    @IBOutlet weak var lbEarned:UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func setupView() {
        super.setupView()
//        navBar.isHidden = true
        navBar.leftNavBar = .none
        navBar.rightNavBar = .logout
        showIndicator()
        let userProfile = UserLoginInfo.shared.userInfo
        lbName.text = userProfile.name!
        hideIndicator()
    }
    
    @IBAction func answerQuestionsPressed(_ sender: UIButton){
        self.performSegue(withIdentifier: "PendingQuestionVC", sender: nil)
    }
    
    @IBAction func answerHistoryPressed(_ sender: UIButton){
        self.performSegue(withIdentifier: "AnswerHistoryVC", sender: nil)
    }

}
