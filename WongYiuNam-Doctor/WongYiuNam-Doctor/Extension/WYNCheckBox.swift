//
//  WYNCheckBox.swift
//  WongYiuNam-Doctor
//
//  Created by Admin on 9/13/17.
//  Copyright © 2017 RTH. All rights reserved.
//

import UIKit

class WYNCheckBox: UIButton {

    var isChecked: Bool = false {
        didSet{
            if isChecked {
                self.setImage(#imageLiteral(resourceName: "ic_boxChecked"), for: .normal)
            } else {
                self.setImage(#imageLiteral(resourceName: "ic_boxUnchecked"), for: .normal)
            }
        }
    }
    
    override func awakeFromNib() {
        self.backgroundColor = UIColor.clear
        self.addTarget(self, action: #selector(WYNCheckBox.buttonClicked(_:)), for: .touchUpInside)
        isChecked = false
        
    }
    
    func buttonClicked(_ sender : UIButton){
        print("touched")
        if ( sender == self  ) {
            if isChecked {
                isChecked = false
            } else {
                isChecked = true
            }
            
        }
    }
}
