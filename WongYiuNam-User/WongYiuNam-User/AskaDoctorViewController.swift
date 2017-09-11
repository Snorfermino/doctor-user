//
//  AskaDoctorViewController.swift
//  WongYiuNam-User
//
//  Created by Admin on 9/6/17.
//  Copyright © 2017 RTH. All rights reserved.
//

import UIKit

class AskaDoctorViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let listDoctors = [(name: "Duy Nguyen", status: true), (name: "Ton Nguyen", status: true), (name: "Tam Le", status: false)
                , (name: "Phat Chiem", status: true), (name: "Ri MAP", status: false), (name: "Hung Phan", status: true)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem()
    }
}

extension AskaDoctorViewController: UITableViewDelegate {

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
        if let statusImageView = cell.viewWithTag(101) as? UIImageView {
            if(doctor.status) {
                statusImageView.image = UIImage.from(color: UIColor.green)
            } else {
                statusImageView.image = UIImage.from(color: UIColor.red)
            }
            statusImageView.makeCircular()
        }
        return cell
    }
}

