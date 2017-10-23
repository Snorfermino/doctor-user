//
//  FavoriteViewController.swift
//  WongYiuNam-User
//
//  Created by Admin on 10/8/17.
//  Copyright © 2017 RTH. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class FavoriteDoctorViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var data = Variable([Doctor]())
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        bindUI()
        loadData()
    }
    
    func setUpUI() {
        tableView.registerCellNib(DoctorTableViewCell.self)
    }
    
    func bindUI() {
        data.asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: String.className(DoctorTableViewCell.self), cellType: DoctorTableViewCell.self)) { (row, doctor, cell) in
                cell.doctor = doctor
            }
            .disposed(by: disposeBag)
    }
    
    func loadData() {
        let completion = {(data: [Doctor]?, error: String?) -> Void in
            guard let data = data else {
                Utils.showAlert(title: "Error !!!", message: error, viewController: self)
                return
            }
            self.data.value = data
            self.tableView.reloadData()
        }
        ApiManager.getFavoritesDoctors(completion: completion)
    }
}
