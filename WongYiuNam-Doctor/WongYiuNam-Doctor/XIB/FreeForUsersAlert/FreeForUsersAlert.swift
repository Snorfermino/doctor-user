//
//  FreeForUsersAlert.swift
//  WongYiuNam-Doctor
//
//  Created by Admin on 11/2/17.
//  Copyright © 2017 RTH. All rights reserved.
//

import UIKit
import UIKit
protocol AlertPresenting {}

extension AlertPresenting {
    func showAlert(_ onView: UIView, delegate: FreeForUsersAlertDelegate) {
//        if let alert = Bundle.main.loadNibNamed("FreeForUserAlert", owner: self, options: nil) {
//            alert.translatesAutoresizingMaskIntoConstraints = false
//
//            onView.addSubview(alert)
//            //here define constraints
//            onView.bringSubview(toFront: alert)
//        }
        let alertView = FreeForUserAlert(frame: onView.bounds)
        alertView.translatesAutoresizingMaskIntoConstraints = false
        alertView.delegate = delegate
        onView.addSubview(alertView)
        onView.bringSubview(toFront: alertView)
        let views = ["alert": alertView,
                     "view": onView]
        var allConstraints = [NSLayoutConstraint]()
        let hFormat = NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-0-[alert]-0-|",
            options: [],
            metrics: nil,
            views: views)
        allConstraints += hFormat
        let vFormat = NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-0-[alert]-0-|",
            options: [],
            metrics: nil,
            views: views)
        allConstraints += vFormat
        NSLayoutConstraint.activate(allConstraints)
    }
}
protocol FreeForUsersAlertDelegate {
    func cancel()
    func yes()
}
class FreeForUserAlert: UIView {
    @IBOutlet weak var mainView: UIView!
     @IBOutlet weak var contentView: UIView!
    var delegate:FreeForUsersAlertDelegate?
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit(){
        
        Bundle.main.loadNibNamed("FreeForUserAlert", owner: self, options: nil)
        
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.backgroundColor = UIColor.gray.withAlphaComponent(0.15)
//        mainView.backgroundColor = UIColor.white.withAlphaComponent(0.15)
//        contentView.backgroundColor = UIColor.white
    }
    
    @IBAction func cancelPressed(_ sender: Any){
        self.removeFromSuperview()
        delegate?.cancel()
    }
    @IBAction func yesPressed(_ sender: Any){
        self.removeFromSuperview()
        delegate?.yes()
    }
}
