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
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func setupView() {
        super.setupView()
        //        navBar.isHidden = true
        setupTableVIew()
        navBar.leftNavBar = .none
        navBar.rightNavBar = .logout
        
        let userProfile = UserLoginInfo.shared.userInfo
        let avatarURL = URL(string: userProfile.avatar!)
        imageViewAvatar.sd_setImage(with: avatarURL , placeholderImage: #imageLiteral(resourceName: "ic_logo"), options: [.retryFailed]) { (image, error, cacheType, url) in
            print("image \(String(describing: image)) error \(String(describing: error)) cacheType \(cacheType) url \(String(describing: url)))")
        }
        
        lbName.text = userProfile.name!
//        lbSpeciality.text = userProfile.speciality!
//        lbQualifications.text = userProfile.qualifications!
//        btnAvailable.isSelected = userProfile.online!
//        let index = lbEarned.text!.range(of: "Amount Earned This Month: ")
//        let earnText = lbEarned.text!.substring(with: index!)
//
//        let attributeString = NSMutableAttributedString(string: earnText + userProfile.totalEarned!)
//
//        attributeString.addAttribute(NSForegroundColorAttributeName, value: UIColor(hex: 0xFF7878), range: NSRange(location:25,length:userProfile.totalEarned!.count + 1))
//
//        lbEarned.attributedText = attributeString
    }
    
    func setupTableVIew(){
        tableView.register(UINib(nibName: "AvailableToAnswerCell", bundle: nil), forCellReuseIdentifier: "AvailableToAnswerCell")
        tableView.register(UINib(nibName: "DoctorInfoCell", bundle: nil), forCellReuseIdentifier: "DoctorInfoCell")
        tableView.estimatedRowHeight = 58
        tableView.rowHeight = 58 / 667 * UIScreen.main.bounds.height
        tableView.separatorStyle = .singleLine
        
    }
    
    @IBAction func answerQuestionsPressed(_ sender: UIButton){
        self.performSegue(withIdentifier: "PendingQuestionVC", sender: nil)
    }
    
    @IBAction func answerHistoryPressed(_ sender: UIButton){
        self.performSegue(withIdentifier: "AnswerHistoryVC", sender: nil)
    }
    
}
extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return ((section != 0) ? 15 : 0)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let footer = UIView()
        footer.backgroundColor = UIColor.clear
        return footer
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let userProfile = UserLoginInfo.shared.userInfo
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AvailableToAnswerCell") as! AvailableToAnswerCell
            cell.isAvailable = userProfile.online!
            return cell
        default:
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: "DoctorInfoCell") as! DoctorInfoCell
                cell.lbSkill.text = "Speciality"
                cell.lbSkillInfo.text = userProfile.speciality
                cell.imgViewSkill.image = #imageLiteral(resourceName: "ic_speciality")
                return cell
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: "DoctorInfoCell") as! DoctorInfoCell
                cell.lbSkill.text = "Experience"
                cell.lbSkillInfo.text = userProfile.speciality
                cell.imgViewSkill.image = #imageLiteral(resourceName: "ic_exp")
                return cell
            case 2:
                let cell = tableView.dequeueReusableCell(withIdentifier: "DoctorInfoCell") as! DoctorInfoCell
                cell.lbSkill.text = "Language"
                cell.lbSkillInfo.text = userProfile.speciality
                cell.imgViewSkill.image = #imageLiteral(resourceName: "ic_language")
                return cell
            default:
                let cell = tableView.dequeueReusableCell(withIdentifier: "DoctorInfoCell") as! DoctorInfoCell
                cell.lbSkill.text = "Language"
                cell.lbSkillInfo.text = userProfile.speciality
                cell.imgViewSkill.image = #imageLiteral(resourceName: "ic_earned")
                return cell
                
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("soomething")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return 4
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
}
