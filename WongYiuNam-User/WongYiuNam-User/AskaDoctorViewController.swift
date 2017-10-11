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
    var data: [Doctor] = []
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
        loadData()
    }
    
    @objc func refresh(sender:AnyObject) {
        let completion = {(data: [Doctor]) -> Void in
            self.refreshControl.endRefreshing()
            self.data = data
            self.tableView.reloadData()
        }
        page = 1
        ApiManager.getDoctors(page: page, completion: completion)
    }
    
    @objc func loadMoreTableView() {
        let completion = {(data: [Doctor]) -> Void in
            self.tableView.loadControl?.endLoading()
            self.data.append(contentsOf: data)
            self.tableView.reloadData()
        }
        page += 1
        ApiManager.getDoctors(page: page, completion: completion)
    }
    
    func loadData() {
        activityIndicatorView.startAnimating()
        let completion = {(data: [Doctor]) -> Void in
            self.activityIndicatorView.stopAnimating()
            self.data = data
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
            destinationVC.doctor = data[idx.row]
        }
    }
}

extension AskaDoctorViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("DoctorTableViewCell", owner: self, options: nil)?.first as! DoctorTableViewCell
        cell.setup(doctor: data[indexPath.row])
        return cell
    }
}

extension AskaDoctorViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.loadControl?.update()
    }
}

