//
//  CheckBoxButton.swift
//  FM-Net
//
//  Created by Thuannq on 4/29/16.
//  Copyright © 2016 Bravesoft-Vn. All rights reserved.
//

import UIKit

protocol CheckBoxButtonDelegate{
    func buttonClicked(value : Bool)
    
}

class CheckBoxButton: UIButton {

    var delegate : CheckBoxButtonDelegate?
    let checkedImage = UIImage(named: "ic_check_on")! as UIImage
    let uncheckedImage = UIImage(named: "ic_check")! as UIImage
    
    var isChecked: Bool = false {
        didSet{
            if isChecked == true {
                self.setBackgroundImage(checkedImage, for: .normal)
            } else {
                self.setBackgroundImage(uncheckedImage, for: .normal)
            }
        }
    }
    
    override func awakeFromNib() {
        self.addTarget(self, action: #selector(buttonClicked(sender:)), for: UIControlEvents.touchUpInside)
        self.isChecked = false
    }
    
    func buttonClicked(sender: UIButton) {
        if sender == self {
            if isChecked == true {
                isChecked = false
            } else {
                isChecked = true
            }
        }
        
        delegate?.buttonClicked(value: isChecked)
    }
}
