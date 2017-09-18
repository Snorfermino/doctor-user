//
//  DRPLoadingSpinner.swift
//  WongYiuNam-User
//
//  Created by Admin on 9/18/17.
//  Copyright © 2017 RTH. All rights reserved.
//

import DRPLoadingSpinner

extension DRPLoadingSpinner {
    
    func initView(view: UIView) {
        colorSequence = [UIColor.init(red: 228, green: 175, blue: 120), UIColor.init(red: 211, green: 180, blue: 144)]
        frame = CGRect(x: view.center.x - 20, y: view.center.y - 120, width: 40, height: 40)
    }
}
