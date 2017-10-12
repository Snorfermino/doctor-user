//
//  TopUpViewController.swift
//  WongYiuNam-User
//
//  Created by Admin on 10/11/17.
//  Copyright © 2017 RTH. All rights reserved.
//

import UIKit
import BraintreeDropIn
import Braintree
import KRProgressHUD
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
        guard let tappedView = sender.view else { return }
        print("Tag: \(tappedView.tag)")
        selectedCredit = tappedView.tag
    }
    
    func getPaymentToken(){
        let completion = { [unowned self] (paymentToken: String?,error: String?) in
            guard let token = paymentToken else {
               KRProgressHUD.dismiss()
                self.alert(title: "Error", message: "Invalid Payment Token")
                return
            }
            self.showDropIn(token)
        }
        ApiManager.getPaymentToken(completion: completion)
    }
    
    func showDropIn(_ clientTokenOrTokenizationKey: String) {
        let request =  BTDropInRequest()
        let dropIn = BTDropInController(authorization: clientTokenOrTokenizationKey, request: request)
        { (controller, result, error) in
            if (error != nil) {
                print("ERROR")
            } else if (result?.isCancelled == true) {
                print("CANCELLED")
            } else if let result = result {
                KRProgressHUD.dismiss()
                // Use the BTDropInResult properties to update your UI
                // result.paymentOptionType
                // result.paymentMethod
                // result.paymentIcon
                // result.paymentDescription
            }
            controller.dismiss(animated: true, completion: nil)
        }
        self.present(dropIn!, animated: true, completion: nil)
    }
    
    @IBAction func topUpPressed(_ sender: UIButton){
        KRProgressHUD.show()
        getPaymentToken()
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
