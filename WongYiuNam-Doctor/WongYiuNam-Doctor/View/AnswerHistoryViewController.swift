//
//  AnswerHistoryViewController.swift
//  WongYiuNam-Doctor
//
//  Created by Admin on 9/26/17.
//  Copyright © 2017 RTH. All rights reserved.
//

import UIKit
import SVProgressHUD

class AnswerHistoryViewController: BaseViewController {
    @IBOutlet weak var tableView: UITableView!

    var viewModel: AnswerHistoryViewModel!
    var selectedAnswerDetail: WYNAnswerHistory.WYNData!
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(AnswerHistoryViewController.handleRefresh(_:)),
                                 for: UIControlEvents.valueChanged)
        refreshControl.tintColor = UIColor.black
        
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = AnswerHistoryViewModel(self)
        setupView()
    }

    override func setupView() {
        super.setupView()
        setupNavBar(.none,.back,"Answer History")
        SVProgressHUD.show()
        setupTableView()
        viewModel.getAnswerHistoryList()
    }
    func setupTableView(){
        tableView.register(UINib(nibName: "AnswerHistoryCell", bundle: nil), forCellReuseIdentifier: "AnswerHistoryCell")
        tableView.estimatedRowHeight = 340
        tableView.rowHeight = 340 / 667 * UIScreen.main.bounds.height
        tableView.separatorStyle = .none
        tableView.addSubview(refreshControl)
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        
        viewModel.getAnswerHistoryList()
        SVProgressHUD.show()
        self.tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? AnswerDetailViewController {
            if self.selectedAnswerDetail != nil {
                viewController.answerDetailsData = self.selectedAnswerDetail
            }
        }
    }
}
extension AnswerHistoryViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let footer = UIView()
        footer.backgroundColor = UIColor.clear
        return footer
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AnswerHistoryCell") as! AnswerHistoryCell
        if viewModel.answerHistory.count > 0 {
            cell.cellData = self.viewModel.answerHistory[indexPath.section]
        }
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if viewModel.answerHistory.count > 0 {
            selectedAnswerDetail = self.viewModel.answerHistory[indexPath.section]
        }
        self.performSegue(withIdentifier: "AnswerDetailVC", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.answerHistory.count
    }
}
extension AnswerHistoryViewController: AnswerHistoryViewModelDelegate {
    func getAnswerHistoryListSuccess() {
        SVProgressHUD.dismiss()
        tableView.reloadData()
    }
    func getAnswerHistoryListFailed () {
        SVProgressHUD.dismiss()
        alert(title: "Error", message: "Answer History not found")
        tableView.reloadData()
    }
}
