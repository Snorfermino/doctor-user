//
//  AskaDoctorViewController.swift
//  WongYiuNam-User
//
//  Created by Admin on 9/6/17.
//  Copyright © 2017 RTH. All rights reserved.
//

import UIKit
import DRPLoadingSpinner
import UILoadControl

class AskaDoctorViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    var listDoctors: [Doctor] = []
    let activityIndicatorView = DRPLoadingSpinner()
    var idx: IndexPath = IndexPath(row: 0, section: 0)
    var page = 1
    var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        activityIndicatorView.initView(view: view)
        tableView.addSubview(activityIndicatorView)
        tableView.loadControl = UILoadControl(target: self, action: #selector(loadMoreTableView))
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh), for: UIControlEvents.valueChanged)
        tableView.addSubview(refreshControl) // not required when using UITableViewController
        loadListDoctors()
    }
    
    @objc func refresh(sender:AnyObject) {
        let completion = {(data: [Doctor]) -> Void in
            self.refreshControl.endRefreshing()
            self.listDoctors = data
            self.tableView.reloadData()
        }
        page = 1
        ApiManager.getDoctors(page: page, completion: completion)
    }
    
    @objc func loadMoreTableView() {
        let completion = {(data: [Doctor]) -> Void in
            self.tableView.loadControl?.endLoading()
            self.listDoctors.append(contentsOf: data)
            self.tableView.reloadData()
        }
        page += 1
        ApiManager.getDoctors(page: page, completion: completion)
    }
    
    func loadListDoctors() {
        activityIndicatorView.startAnimating()
        let completion = {(data: [Doctor]) -> Void in
            self.activityIndicatorView.stopAnimating()
            self.listDoctors = data
            self.tableView.reloadData()
        }
        page = 1
        ApiManager.getDoctors(page: page, completion: completion)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem()
    }
    
    @IBAction func doctorIntroductionButtonClicked(_ sender: Any) {
        
    }
}

extension AskaDoctorViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        idx = indexPath
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "askaDoctorToDoctorIntroductionSegue" {
            let destinationVC:DoctorIntroductionViewController = segue.destination as! DoctorIntroductionViewController
            destinationVC.doctor = listDoctors[idx.row]
        }
    }
}

extension AskaDoctorViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listDoctors.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "askaDoctorCellIdentifier")!
        let doctor = listDoctors[indexPath.row]
        if let nameLabel = cell.viewWithTag(100) as? UILabel {
            nameLabel.text = doctor.name
        }
        if let specialtyLabel = cell.viewWithTag(103) as? UILabel {
            specialtyLabel.text = doctor.speciality
        }
        if let introductionLabel = cell.viewWithTag(104) as? UILabel {
            introductionLabel.text = doctor.introduction
        }
        if let likeImageView = cell.viewWithTag(105) as? UIImageView {
            //
        }
        if let statusView = cell.viewWithTag(101) {
            if(doctor.online == false) {
                statusView.backgroundColor = UIColor.red
            }
            statusView.makeCircular()
        }
        if let avatarButton = cell.viewWithTag(102) as? UIButton {
            //
        }
        return cell
    }
}

extension AskaDoctorViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.loadControl?.update()
    }
}

