//
//  FavoriteButton.swift
//  WongYiuNam-User
//
//  Created by Admin on 9/20/17.
//  Copyright © 2017 RTH. All rights reserved.
//

import UIKit

class FavoriteButton: UIButton {
    
    var isChecked: Bool = false {
        didSet{
            if isChecked {
                self.setImage(#imageLiteral(resourceName: "img_favChecked"), for: .normal)
            } else {
                self.setImage(#imageLiteral(resourceName: "img_favUnchecked"), for: .normal)
            }
        }
    }
    
    override func awakeFromNib() {
        self.backgroundColor = UIColor.clear
        self.addTarget(self, action: #selector(FavoriteButton.buttonClicked(_:)), for: .touchUpInside)
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
