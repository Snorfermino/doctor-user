//
//  PendingQuestionViewController.swift
//  WongYiuNam-Doctor
//
//  Created by Admin on 9/14/17.
//  Copyright © 2017 RTH. All rights reserved.
//

import UIKit

class PendingQuestionViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var viewModel:PendingQuestionViewModel = PendingQuestionViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.getPendingQuestionList(id: 4)
        setupView()
    }
    
    override func setupView() {
        setupTableView()
        guard let userInfo:WYNLogedInUserInfo = UserLoginInfo.shared.userInfo as WYNLogedInUserInfo else {
            return
        }
        viewModel.getPendingQuestionList(id: userInfo.id!)
    }
    
    func setupTableView(){
        tableView.register(UINib(nibName: "PendingQuestion", bundle: nil), forCellReuseIdentifier: "PendingQuestionCell")
        tableView.estimatedRowHeight = 230
        tableView.rowHeight = 230
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
        let newImageView = UIImageView(image: imageView.image)
        newImageView.frame = UIScreen.main.bounds
        newImageView.backgroundColor = .black
        newImageView.contentMode = .scaleAspectFit
        newImageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImage))
        newImageView.addGestureRecognizer(tap)
        self.view.addSubview(newImageView)
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }
    
    func dismissFullscreenImage(_ sender: UITapGestureRecognizer) {
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = false
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
            cell.tvQuestion.text = self.viewModel.pendingQuestions[indexPath.section].question
        }
        let tapGest = UITapGestureRecognizer(target: self, action: #selector(imageTapped(_:)))
        cell.addGestureRecognizer(tapGest)

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("soomething")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.pendingQuestions.count
    }

}
extension PendingQuestionViewController: PendingQuestionViewModelDelegate{
    func getPendingQuestionListDone() {
        tableView.reloadData()
    }
}


