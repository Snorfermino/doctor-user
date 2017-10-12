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

    func getPaymentToken(){
        let completion = { [unowned self] (paymentToken: String?,error: String?) in
            guard let token = paymentToken else { return }
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
