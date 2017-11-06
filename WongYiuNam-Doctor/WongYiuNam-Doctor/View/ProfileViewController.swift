//
//  ProfileViewController.swift
//  WongYiuNam-Doctor
//
//  Created by Admin on 9/13/17.
//  Copyright © 2017 RTH. All rights reserved.
//

import UIKit
import SDWebImage
import SVProgressHUD
class ProfileViewController: BaseViewController {
    @IBOutlet weak var imageViewAvatar:UIImageView!
    @IBOutlet weak var lbName:UILabel!
    @IBOutlet weak var viewOnlineIndicator:UIView!
    @IBOutlet weak var viewPendingQuestionNoti:UIView!
    @IBOutlet weak var lbPendingQuestion:UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnCheckbox: UIButton!
    @IBOutlet weak var checkbox: WYNCheckBox!
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(PendingQuestionViewController.handleRefresh(_:)),
                                 for: UIControlEvents.valueChanged)
        refreshControl.tintColor = UIColor.clear
        return refreshControl
    }()
    
    var isAvailable: Bool = false
    {
        didSet{
            checkbox.isSelected = isAvailable
            viewOnlineIndicator.isHidden = !checkbox.isSelected

        }
    }
    
    
    var viewModel: ProfileViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ProfileViewModel(self)
        viewModel.getProfile()
        SVProgressHUD.show()
        setupView()
    }
    override func setupView() {
        super.setupView()
        checkbox.delegate = self
        setupTableVIew()
        setupNavBar(.logout, .none,  "Physician Profile")
        let userProfile = UserLoginInfo.shared.userInfo
        

        isAvailable = userProfile.online!
        lbName.text = userProfile.name
        if userProfile.pendingQuestions! > 0 {
            viewPendingQuestionNoti.isHidden = false
            lbPendingQuestion.text = "\(userProfile.pendingQuestions!)"
        } else {
            viewPendingQuestionNoti.isHidden = true
        }
        guard userProfile.avatar != nil else { return }
        let avatarURL = URL(string: userProfile.avatar!)
        imageViewAvatar.sd_setImage(with: avatarURL! , placeholderImage: #imageLiteral(resourceName: "ic_logo"), options: [.retryFailed]) { (image, error, cacheType, url) in
            print("image \(String(describing: image)) error \(String(describing: error)) cacheType \(cacheType) url \(String(describing: url)))")
            self.imageViewAvatar.image = image
        }
    }
    
    func setupTableVIew(){
        tableView.register(UINib(nibName: "DoctorInfoCell", bundle: nil), forCellReuseIdentifier: "DoctorInfoCell")
        tableView.estimatedRowHeight = 58
        tableView.rowHeight = 58 / 667 * UIScreen.main.bounds.height
        tableView.separatorStyle = .singleLine
        tableView.addSubview(refreshControl)
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        
        //TODO: Implement get additional pending questions
        viewModel.getProfile()
        SVProgressHUD.show()

    }
    
    @IBAction func btnCheckboxPressed(_ sender: Any) {
        viewModel.isOnline(!isAvailable)
        SVProgressHUD.show()
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
//        viewOnlineIndicator.isHidden = !isSelected

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
            cell.lbSkillInfo.text = userProfile.experience
            cell.imgViewSkill.image = #imageLiteral(resourceName: "ic_exp")
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DoctorInfoCell") as! DoctorInfoCell
            cell.lbSkill.text = "Qualification"
            cell.lbSkillInfo.text = userProfile.qualifications
            cell.imgViewSkill.image = #imageLiteral(resourceName: "ic_language")
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DoctorInfoCell") as! DoctorInfoCell
            cell.lbSkill.text = "Amount Earned This Month"
            cell.lbSkillInfo.text = userProfile.totalEarned != nil ? userProfile.totalEarned : "S$0.0"
            cell.imgViewSkill.image = #imageLiteral(resourceName: "ic_earned")
            return cell
            
        }
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 4
    }

}
extension ProfileViewController: ProfileViewModelDelegate{
    func getDoctorProfileSuccess() {
        SVProgressHUD.dismiss()
        self.tableView.reloadData()
        refreshControl.endRefreshing()
        tableView.reloadData()
    }
    
    func getDoctorProfileFailed() {
        tableView.reloadData()
    }
    
    func doctor(isOnline: Bool) {
        UserLoginInfo.shared.userInfo.online = isOnline
        SVProgressHUD.dismiss()
        tableView.reloadData()
        isAvailable = isOnline
    }
}
