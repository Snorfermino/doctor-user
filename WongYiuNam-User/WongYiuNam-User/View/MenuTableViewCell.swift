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
    
    open func setData(image: UIImage?, string: String?, submenu: Bool) {
        if let string = string {
            label.text = string
        }
        if let image = image {
            dataImage.image = image
        }
        if submenu {
            label.frame.origin.x += 35
            dataImage.frame.origin.x += 35
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
