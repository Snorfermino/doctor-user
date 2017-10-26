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
    @IBOutlet weak var viewOnlineIndicator:UIView!
    @IBOutlet weak var viewPendingQuestionNoti:UIView!
    @IBOutlet weak var lbPendingQuestion:UILabel!
    @IBOutlet weak var tableView: UITableView!
    var viewModel: ProfileViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    override func setupView() {
        super.setupView()
        setupTableVIew()
        setupNavBar(.logout, .none,  "Physician Profile")
        let userProfile = UserLoginInfo.shared.userInfo
        imageViewAvatar.sd_setImage(with: userProfile.avatar , placeholderImage: #imageLiteral(resourceName: "ic_logo"), options: [.retryFailed]) { (image, error, cacheType, url) in
            print("image \(String(describing: image)) error \(String(describing: error)) cacheType \(cacheType) url \(String(describing: url)))")
        }
        lbName.text = userProfile.name
        if userProfile.pendingQuestions! > 0 {
            viewPendingQuestionNoti.isHidden = false
            lbPendingQuestion.text = "\(userProfile.pendingQuestions!)"
        } else {
            viewPendingQuestionNoti.isHidden = true
        }
        viewOnlineIndicator.isHidden = true
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
extension ProfileViewController: WYNCheckBoxDelegate{
    func WYNCheckBoxClicked(isSelected: Bool) {
        viewOnlineIndicator.isHidden = !isSelected
        
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
            cell.checkbox.delegate = self
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
                cell.lbSkill.text = "Amount Earned This Month"
                cell.lbSkillInfo.text = userProfile.totalEarned
                cell.imgViewSkill.image = #imageLiteral(resourceName: "ic_earned")
                return cell
                
            }
        }
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
