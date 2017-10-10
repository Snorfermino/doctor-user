//
//  MyWalletViewController.swift
//  WongYiuNam-User
//
//  Created by Admin on 10/10/17.
//  Copyright © 2017 RTH. All rights reserved.
//

import UIKit

class MyWalletViewController: BaseViewController {
    @IBOutlet weak var lbCashRebate: UILabel!
    @IBOutlet weak var lbPoints: UILabel!
    @IBOutlet weak var lbCreditBalance: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func topUpPressed(_ sender: UIButton){
        performSegue(withIdentifier: "TopupCreditsVC", sender: nil)
    }
}
