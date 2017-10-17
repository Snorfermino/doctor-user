//
//  NotificationsViewController.swift
//  WongYiuNam-User
//
//  Created by Admin on 9/8/17.
//  Copyright © 2017 RTH. All rights reserved.
//

import UIKit
import DateToolsSwift
class NotificationsViewController: BaseViewController {
    var notiList: [[String:Date]] = []
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    func setupTableView(){
        tableView.register(UINib(nibName: "NotificationHistoryCell", bundle: nil), forCellReuseIdentifier: "NotificationHistoryCell")
        tableView.estimatedRowHeight = 145
        tableView.rowHeight = 145 / 667 * UIScreen.main.bounds.height
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
}
extension NotificationsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let footer = UIView()
        footer.backgroundColor = UIColor.clear
        return footer
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationHistoryCell") as! NotificationHistoryCell
        if notiList.count > 0 {
            let noti = notiList[indexPath.section]

            cell.lbCreatedDate.text = noti["createdAt"]?.format(with: "HH:mm MMMM dd yyyy")
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("soomething")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return notiList.count
    }
    
}
