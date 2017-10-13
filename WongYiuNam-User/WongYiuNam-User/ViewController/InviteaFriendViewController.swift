//
//  InviteaFriendViewController.swift
//  WongYiuNam-User
//
//  Created by Admin on 9/8/17.
//  Copyright © 2017 RTH. All rights reserved.
//

import UIKit

class InviteaFriendViewController: UIViewController {

    @IBOutlet weak var inviteCodeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let code = Global.user?.info?.invitationCode {
            inviteCodeLabel.text = code
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBarItem()
    }
}
