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
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = AnswerHistoryViewModel(self)
        setupView()
        // TODO: delete this comment because it shows nothing
        // Do any additional setup after loading the view.
    }

    override func setupView() {
        super.setupView()
        // TODO: extract setUpNavBar
        navBar.rightNavBar = .none
        navBar.leftNavBar = .back
        navBar.lbTitle.text = "Answer History"
        SVProgressHUD.show()
        setupTableView()
        viewModel.getAnswerHistoryList()
    }
    func setupTableView(){
        tableView.register(UINib(nibName: "AnswerHistoryCell", bundle: nil), forCellReuseIdentifier: "AnswerHistoryCell")
        tableView.estimatedRowHeight = 340
        tableView.rowHeight = 340 / 667 * UIScreen.main.bounds.height
        tableView.separatorStyle = .none
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
            // TODO: move this logic to Cell
            // TODO: `self.viewModel.answerHistory[indexPath.section]` this line of code is duplicate
            // when need to use a model multiple times, please change to answerHistory = self.viewModel.answerHistory[indexPath.section]
            cell.lbQuestion.text = self.viewModel.answerHistory[indexPath.section].question?.question
            cell.lbCreatedAt.text = self.viewModel.answerHistory[indexPath.section].createdAt!.format(with: "HH:mm MMMM dd yyyy")
        }
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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
        // TODO: remove test code
//        return 5
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
