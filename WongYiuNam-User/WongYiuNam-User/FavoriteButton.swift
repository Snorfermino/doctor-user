//
//  FavoriteButton.swift
//  WongYiuNam-User
//
//  Created by Admin on 9/20/17.
//  Copyright © 2017 RTH. All rights reserved.
//

import UIKit

class FavoriteButton: UIButton {
    
    override var isSelected: Bool {
        didSet{
            let image = isSelected ? #imageLiteral(resourceName: "img_favChecked") : #imageLiteral(resourceName: "img_favUnchecked")
            setImage(image, for: .normal)
        }
    }
    
    override func awakeFromNib() {
        self.backgroundColor = UIColor.clear
        // TODO: this logic should be move to ProductCell configuration
//        self.addTarget(self, action: #selector(FavoriteButton.buttonClicked(_:)), for: .touchUpInside)
    }
    
//    @objc func buttonClicked(_ sender : UIButton){
//        print("touched")
//        if ( sender == self  ) {
//            if isChecked {
//                isChecked = false
//            } else {
//                isChecked = true
//            }
//
//        }
//    }
}
