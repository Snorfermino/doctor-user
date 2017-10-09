//
//  FavoriteViewController.swift
//  WongYiuNam-User
//
//  Created by Admin on 10/8/17.
//  Copyright © 2017 RTH. All rights reserved.
//

import UIKit

class FavoriteDoctorViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var data: [Doctor] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //loadData()
        //tableView.delegate = self
        tableView.dataSource = self
        loadFakeData()
    }
    
    func loadFakeData() {
        var doctor = Doctor()
        doctor.name = "Demo Abc"
        data.append(doctor)
        data.append(doctor)
        data.append(doctor)
        data.append(doctor)
        data.append(doctor)
        tableView.reloadData()
    }
    
    func loadData() {
        let completion = {(data: [Doctor]?, error: String?) -> Void in
            guard let data = data else {
                Utils.showAlert(title: "Error !!!", message: error, viewController: self)
                return
            }
            self.data = data
            self.tableView.reloadData()
        }
    }
}

extension FavoriteDoctorViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("DoctorTableViewCell", owner: self, options: nil)?.first as! DoctorTableViewCell
        cell.setup(doctor: data[indexPath.row])
        return cell
    }
}
