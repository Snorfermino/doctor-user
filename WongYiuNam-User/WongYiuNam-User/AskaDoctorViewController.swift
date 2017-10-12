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
import RxSwift
import RxCocoa

class AskaDoctorViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var data = Variable([Doctor]())
    let activityIndicatorView = DRPLoadingSpinner()
    var idx: IndexPath = IndexPath(row: 0, section: 0)
    var page = 1
    var refreshControl: UIRefreshControl!
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicatorView.initView(view: view)
        setUpTableView()
        bindUI()
        loadData()
    }
    
    func setUpTableView() {
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh), for: UIControlEvents.valueChanged)
        tableView.addSubview(refreshControl)
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.addSubview(activityIndicatorView)
        tableView.loadControl = UILoadControl(target: self, action: #selector(loadMoreTableView))
        tableView.registerCellNib(DoctorTableViewCell.self)
    }
    
    func bindUI() {
        data.asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: String.className(DoctorTableViewCell.self), cellType: DoctorTableViewCell.self)) { (row, doctor, cell) in
                cell.doctor = doctor
            }
            .disposed(by: disposeBag)
    }
    
    @objc func refresh(sender:AnyObject) {
        let completion = {(data: [Doctor]) -> Void in
            self.refreshControl.endRefreshing()
            self.data.value = data
            self.tableView.reloadData()
        }
        page = 1
        ApiManager.getDoctors(page: page, completion: completion)
    }
    
    @objc func loadMoreTableView() {
        let completion = {(data: [Doctor]) -> Void in
            self.tableView.loadControl?.endLoading()
            self.data.value.append(contentsOf: data)
            self.tableView.reloadData()
        }
        page += 1
        ApiManager.getDoctors(page: page, completion: completion)
    }
    
    func loadData() {
        activityIndicatorView.startAnimating()
        let completion = {(data: [Doctor]) -> Void in
            self.activityIndicatorView.stopAnimating()
            self.data.value = data
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
        if let destinationVC = segue.destination as? DoctorIntroductionViewController {
            destinationVC.doctor = data.value[idx.row]
        }
    }
}

extension AskaDoctorViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.loadControl?.update()
    }
}

