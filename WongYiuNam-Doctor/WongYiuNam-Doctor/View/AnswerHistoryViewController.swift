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
        // Do any additional setup after loading the view.
    }

    override func setupView() {
        super.setupView()
        navBar.rightNavBar = .none
        navBar.leftNavBar = .back
        SVProgressHUD.show()
        setupTableView()
        viewModel.getAnswerHistoryList()
    }
    func setupTableView(){
        tableView.register(UINib(nibName: "AnswerHistoryCell", bundle: nil), forCellReuseIdentifier: "AnswerHistoryCell")
        
        tableView.estimatedRowHeight = 230
        tableView.rowHeight = 230 / 667 * UIScreen.main.bounds.height
        tableView.separatorStyle = .none
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? AnswerDetailViewController {
            viewController.answerDetailsData = self.selectedAnswerDetail
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
            cell.tvQuestion.text = self.viewModel.answerHistory[indexPath.section].question?.question
            let date = Date(timeIntervalSince1970: Double(self.viewModel.answerHistory[indexPath.section].createdAt!))
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm MMMM dd yyyy"
            cell.lbCreatedAt.text = dateFormatter.string(from: date)
        }
        cell.tvQuestion.isEditable = false
        cell.tvQuestion.isScrollEnabled = false
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("soomething")
        selectedAnswerDetail = self.viewModel.answerHistory[indexPath.section]
        self.performSegue(withIdentifier: "AnswerDetailVC", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.answerHistory.count
//        return 5
    }
    
}
extension AnswerHistoryViewController: AnswerHistoryViewModelDelegate {
    func getAnswerHistoryListSuccess() {
//        hideIndicator()
        SVProgressHUD.dismiss()
        tableView.reloadData()
    }
    func getAnswerHistoryListFailed () {
//        hideIndicator()
             SVProgressHUD.dismiss()
        alert(title: "Error", message: "Answer History not found")
        tableView.reloadData()
    }
}
