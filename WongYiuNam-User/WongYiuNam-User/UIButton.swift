//
//  UIButton.swift
//  WongYiuNam-User
//
//  Created by Admin on 9/11/17.
//  Copyright © 2017 RTH. All rights reserved.
//

import UIKit

extension UIButton {
    func makeCircular() {
        layer.cornerRadius = frame.width / 2
        clipsToBounds = true
    }
}
