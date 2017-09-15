//
//  ListenToAnswerViewController.swift
//  WongYiuNam-User
//
//  Created by Admin on 9/11/17.
//  Copyright © 2017 RTH. All rights reserved.
//

import UIKit

class ListenToAnswerViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    let listQuestions = [(question: "I cannot sleep !!! Why?", paid: true), (question: "My wife feels very sad", paid: true), (question: "OK!!! DONE", paid: false)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
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
            //statusButton.buttonType = .custom
            if(question.paid) {
                statusButton.setImage(UIImage(named: "play-button"), for: .normal)
            } else {
                statusButton.setImage(UIImage(named: "play-button-lock"), for: .normal)
            }
            //statusButton.makeCircular()
        }
        return cell
    }
}




