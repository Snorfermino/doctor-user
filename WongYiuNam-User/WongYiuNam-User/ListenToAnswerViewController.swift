//
//  ListenToAnswerViewController.swift
//  WongYiuNam-User
//
//  Created by Admin on 9/11/17.
//  Copyright © 2017 RTH. All rights reserved.
//

import UIKit

class ListenToAnswerViewController: BaseViewController {
    
    @IBOutlet weak var footerView: UIView!
    @IBOutlet weak var tableView: UITableView!
    let listQuestions = [(question: "I cannot sleep !!! Why?", paid: true), (question: "My wife feels very sad pkjas lj laks lkasjlk sjlkfjlaskdjflsaj lk jlska jks jks jk jksj ksjksjfiejowijo", paid: true), (question: "OK!!! DONE", paid: false)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 140
        initFooterView()
    }
    
    func initFooterView() {
        footerView.backgroundColor = UIColor.init(red: 1, green: 1, blue: 1, alpha: 0)
        let colors = [UIColor.init(red: 1, green: 1, blue: 1, alpha: 0), UIColor.init(red: 246, green: 246, blue: 246)]
        footerView.setGradientBackground(colors: colors)
    }
}

extension ListenToAnswerViewController: UITableViewDelegate {
    
}

extension ListenToAnswerViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listQuestions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "listenToAnswerCellIdentifier")!
        let question = listQuestions[indexPath.row]
        if let nameLabel = cell.viewWithTag(100) as? UILabel {
            nameLabel.text = question.question
        }
        if let statusButton = cell.viewWithTag(101) as? UIButton {
            statusButton.setImage(UIImage(named: "play-button"), for: .normal)
        }
        if let freeOrPayLabel = cell.viewWithTag(102) as? UILabel {
            if(question.paid) {
                freeOrPayLabel.text = "Pay to Listen"
            } else {
                freeOrPayLabel.text = "Free to Listen"
            }
        }
        return cell
    }
}




