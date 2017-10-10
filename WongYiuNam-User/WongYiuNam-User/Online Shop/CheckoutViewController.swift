//
//  CheckoutViewController.swift
//  WongYiuNam-User
//
//  Created by Admin on 10/10/17.
//  Copyright © 2017 RTH. All rights reserved.
//

import UIKit
import BraintreeDropIn
import Braintree
class CheckoutViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func getPaymentToken(){
        let completion = {(paymentToken: String?,error: String?) -> Void in
            guard let token = paymentToken else { return }
            showDropIn(token)
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

}
