//
//  WYNCheckBox.swift
//  WongYiuNam-Doctor
//
//  Created by Admin on 9/13/17.
//  Copyright © 2017 RTH. All rights reserved.
//

import UIKit

class WYNCheckBox: UIButton {

    override var isSelected: Bool {
        didSet {
            let image = isSelected ? #imageLiteral(resourceName: "ic_boxChecked") : #imageLiteral(resourceName: "ic_boxUnchecked")
            setImage(image, for: .normal)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.clear
        self.addTarget(self, action: #selector(WYNCheckBox.buttonClicked(_:)), for: .touchUpInside)
    }
    
    @objc func buttonClicked(_ sender : UIButton){
        isSelected = !isSelected
    }
}
