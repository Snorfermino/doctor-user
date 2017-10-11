//
//  TopUpViewController.swift
//  WongYiuNam-User
//
//  Created by Admin on 10/11/17.
//  Copyright © 2017 RTH. All rights reserved.
//

import UIKit

class TopUpViewController: BaseViewController {
    @IBOutlet var tapGesture: UITapGestureRecognizer!
    @IBOutlet var viewCredits:[UIView]!
    var selectedCredit = 0 {
        didSet{
            changeSelectedCredit()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedCredit = 20
        changeSelectedCredit()
        
        for view in viewCredits {
            view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapOnCredit)))
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func tapOnCredit(_ sender: UITapGestureRecognizer){
        guard let tappedView = sender.view as? UIView else { return }
        print("Tag: \(tappedView.tag)")
        selectedCredit = tappedView.tag
    }

    @objc func changeSelectedCredit(){
        for view in viewCredits{
            view.shadowOpacity = 0
            if view.tag == selectedCredit {
                view.shadowOffset = CGSize(width: 0.1, height: 0)
                view.shadowRadius = 3
                view.shadowOpacity = 0.5
            }
        }
    }

}
