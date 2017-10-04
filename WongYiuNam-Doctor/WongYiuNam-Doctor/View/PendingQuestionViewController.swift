//
//  PendingQuestionViewController.swift
//  WongYiuNam-Doctor
//
//  Created by Admin on 9/14/17.
//  Copyright © 2017 RTH. All rights reserved.
//

import UIKit
import SVProgressHUD
import DateToolsSwift

class PendingQuestionViewController: BaseViewController {
    var photoImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    var viewModel:PendingQuestionViewModel = PendingQuestionViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    override func setupView() {
        super.setupView()
        viewModel.delegate = self
        viewModel.getPendingQuestionList()
        SVProgressHUD.show()
        navBar.rightNavBar = .none
        navBar.leftNavBar = .back
        
        setupTableView()
        
//        guard let userInfo:WYNLogedInUserInfo = UserLoginInfo.shared.userInfo as WYNLogedInUserInfo else {
//            return
//        }
//        viewModel.getPendingQuestionList(id: userInfo.id!)
        
    }
    
    func setupTableView(){
        tableView.register(UINib(nibName: "PendingQuestion", bundle: nil), forCellReuseIdentifier: "PendingQuestionCell")
        tableView.estimatedRowHeight = 230
        tableView.rowHeight = 230 / 667 * UIScreen.main.bounds.height
        tableView.separatorStyle = .none
        addTransientView()
    }
    
    func addTransientView(){
        let colour:UIColor = .white
        let colours:[CGColor] = [colour.withAlphaComponent(0.0).cgColor,colour.cgColor]
        let locations:[NSNumber] = [0.6,1]
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colours
        gradientLayer.locations = locations
        
        let screenSize: CGRect = UIScreen.main.bounds
        
        let bottomView = UIView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: 50))
        self.view.addSubview(bottomView)
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        let widthConstraint = NSLayoutConstraint(item: bottomView, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 1.0, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(item: bottomView, attribute: .height, relatedBy: .equal, toItem: bottomView, attribute: .width, multiplier: 50/375, constant: 0.0)
        let bottomConstraint = NSLayoutConstraint(item: bottomView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        
        gradientLayer.frame = bottomView.frame
        
        bottomView.layer.addSublayer(gradientLayer)
        
        self.view.addConstraints([widthConstraint,heightConstraint,bottomConstraint])
    }
    
    func imageTapped(_ sender: UITapGestureRecognizer) {
        let imageView = sender.view as! UIImageView
        photoImage = UIImageView(image: imageView.image)
        let scrollView = UIScrollView(frame: UIScreen.main.bounds)
        scrollView.frame = CGRect(x: 0, y: navBar.frame.height, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - navBar.frame.height)
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 6.0
        scrollView.delegate = self
        photoImage.frame = UIScreen.main.bounds
        photoImage.backgroundColor = UIColor.white.withAlphaComponent(1)
        photoImage.contentMode = .scaleAspectFit
        photoImage.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImage))
        scrollView.addGestureRecognizer(tap)
        
        photoImage.frame = scrollView.bounds
        scrollView.addSubview(photoImage)
        self.view.addSubview(scrollView)
//        self.navigationController?.isNavigationBarHidden = true
//        self.tabBarController?.tabBar.isHidden = true
    }
    
    func dismissFullscreenImage(_ sender: UITapGestureRecognizer) {
//        self.navigationController?.isNavigationBarHidden = false
//        self.tabBarController?.tabBar.isHidden = false
        sender.view?.removeFromSuperview()
    }

}

extension PendingQuestionViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let footer = UIView()
        footer.backgroundColor = UIColor.clear
        return footer
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PendingQuestionCell") as! PendingQuestion
        if viewModel.pendingQuestions.count > 0 {
            let pendingQuestion = self.viewModel.pendingQuestions[indexPath.section]
            cell.lbQuestion.text = pendingQuestion.question
            cell.lbCreatedAt.text = pendingQuestion.createdAt!.format(with: "HH:mm MMMM dd yyyy")
            cell.lbPatientName.text = pendingQuestion.patientName
            cell.lbPatientGender.text = pendingQuestion.patientGender
            cell.lbPatientDOB.text = "\(String(describing: pendingQuestion.patientDob!))"
            cell.imgViewPatientSubmit.sd_setImage(with: pendingQuestion.photoUrl, placeholderImage: #imageLiteral(resourceName: "ic_logo"), options: [.retryFailed], completed: nil)
        }
        cell.imgViewPatientSubmit.isUserInteractionEnabled = true
        let tapGest = UITapGestureRecognizer(target: self, action: #selector(imageTapped(_:)))
        cell.imgViewPatientSubmit.addGestureRecognizer(tapGest)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("soomething")
        performSegue(withIdentifier: "RecordAnswerVC", sender: self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.pendingQuestions.count
    }
    
}
extension PendingQuestionViewController: PendingQuestionViewModelDelegate{
    func getPendingQuestionListSuccess() {
        tableView.reloadData()
        SVProgressHUD.dismiss()
    }
    func getPendingQuestionListFailed() {
        tableView.reloadData()
        SVProgressHUD.dismiss()
        alert(title: "Error", message: "Pending Question not found")
    }
}

extension PendingQuestionViewController: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return photoImage
    }
}
