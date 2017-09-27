//
//  MenuTableViewCell.swift
//  WongYiuNam-User
//
//  Created by Admin on 9/7/17.
//  Copyright © 2017 RTH. All rights reserved.
//

import UIKit

class MenuTableViewCell: UITableViewCell {
    @IBOutlet weak var dataImage: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    class var identifier: String { return String.className(self) }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    open class func height() -> CGFloat {
        return 50
    }
    
    open func setData(_ data: Any?) {
        //self.backgroundColor = UIColor(hex: "F1F8E9")
        //self.textLabel?.font = UIFont.italicSystemFont(ofSize: 18)
        //self.textLabel?.textColor = UIColor(hex: "9E9E9E")
        if let menuText = data as? String {
            self.label.text = menuText
            //self.dataImage.image = UIImage(named: "ic_menu_black_24dp")
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
