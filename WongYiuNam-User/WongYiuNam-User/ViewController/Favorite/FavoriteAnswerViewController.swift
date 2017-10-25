//
//  FavoriteAnswerViewController.swift
//  WongYiuNam-User
//
//  Created by Admin on 10/9/17.
//  Copyright © 2017 RTH. All rights reserved.
//

import UIKit

class FavoriteAnswerViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var data: [Answer] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        //tableView.delegate = self
        tableView.dataSource = self
        //loadFakeData()
    }
    
    func loadData() {
        let completion = {(data: [Answer]?, error: String?) -> Void in
            guard let data = data else {
                Utils.showAlert(title: "Error !!!", message: error, viewController: self)
                return
            }
            self.data = data
            self.tableView.reloadData()
        }
        ApiManager.getFavoritesAnswers(completion: completion)
    }
}

extension FavoriteAnswerViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("AnswerTableViewCell", owner: self, options: nil)?.first as! AnswerTableViewCell
        cell.nameLabel.text = "Eve Stones Duy"
        return cell
    }
}