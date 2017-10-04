//
//  AnswerHistoryViewController.swift
//  WongYiuNam-Doctor
//
//  Created by Admin on 9/26/17.
//  Copyright © 2017 RTH. All rights reserved.
//

import UIKit

class AnswerHistoryViewController: BaseViewController {
    @IBOutlet weak var tableView: UITableView!

    var viewModel: AnswerHistoryViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = AnswerHistoryViewModel(self)
        setupView()
        // Do any additional setup after loading the view.
    }

    override func setupView() {
        super.setupView()
        navBar.rightNavBar = .none
        navBar.leftNavBar = .back
        showIndicator()
        setupTableView()
        viewModel.getAnswerHistoryList()
    }
    func setupTableView(){
        tableView.register(UINib(nibName: "AnswerHistoryCell", bundle: nil), forCellReuseIdentifier: "AnswerHistoryCell")
        tableView.estimatedRowHeight = 230
        tableView.rowHeight = 230
        tableView.separatorStyle = .none
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
            cell.tvQuestion.text = self.viewModel.answerHistory[indexPath.section].question
        }
        cell.tvQuestion.isEditable = false
        cell.tvQuestion.isScrollEnabled = false
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("soomething")
        self.performSegue(withIdentifier: "AnswerDetailVC", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return (viewModel.answerHistory.count > 0) ? viewModel.answerHistory.count : 5
    }
    
}
extension AnswerHistoryViewController: AnswerHistoryViewModelDelegate {
    func getAnswerHistoryListSuccess() {
        hideIndicator()
        tableView.reloadData()
    }
    func getAnswerHistoryListFailed () {
        hideIndicator()
        alert(title: "Error", message: "Answer History not found")
        tableView.reloadData()
    }
}
