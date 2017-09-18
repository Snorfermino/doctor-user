//
//  AskaDoctorViewController.swift
//  WongYiuNam-User
//
//  Created by Admin on 9/6/17.
//  Copyright © 2017 RTH. All rights reserved.
//

import UIKit
import DRPLoadingSpinner

class AskaDoctorViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var listDoctors: [Doctor] = []
    let activityIndicatorView = DRPLoadingSpinner()
    var idx: IndexPath = IndexPath(row: 2, section: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        activityIndicatorView.initView(view: view)
        tableView.addSubview(activityIndicatorView)
        loadListDoctors()
    }
    
    func loadListDoctors() {
        activityIndicatorView.startAnimating()
        let completion = {(data: [Doctor]) -> Void in
            self.activityIndicatorView.stopAnimating()
            self.listDoctors = data
            self.tableView.reloadData()
        }
        ApiManager.getDoctors(completion: completion)
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
            specialtyLabel.text = doctor.specialty
        }
        if let introductionLabel = cell.viewWithTag(104) as? UILabel {
            introductionLabel.text = doctor.introduction
        }
        if let likeImageView = cell.viewWithTag(105) as? UIImageView {
            //
        }
        if let statusView = cell.viewWithTag(101) {
            if(doctor.status == false) {
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

