//
//  MenuTableViewCell.swift
//  WongYiuNam-User
//
//  Created by Admin on 9/7/17.
//  Copyright © 2017 RTH. All rights reserved.
//

import UIKit

enum MenuTableViewCellCorner {
    case normal
    case top
    case bottom
    case full
}

class MenuTableViewCell: UITableViewCell {
    @IBOutlet weak var dataImage: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var menuParentImageView: UIImageView!
    @IBOutlet weak var lineView: UIView!
    
    class var identifier: String { return String.className(self) }

    open class func height() -> CGFloat {
        return 50
    }
    
    open func setData(image: UIImage?, string: String?, corner: MenuTableViewCellCorner, parent: Bool) {
        if let string = string {
            label.text = string
        }
        if let image = image {
            dataImage.image = image
        }
        switch corner {
        case .top:
            containerView.roundCorners([.topLeft, .topRight], radius: 5)
        case .bottom:
            containerView.roundCorners([.bottomLeft, .bottomRight], radius: 5)
        case .full:
            containerView.layer.cornerRadius = 5
        default:
            break
        }
        if parent == false {
            menuParentImageView.isHidden = true
        }
        lineView.isHidden = true
        dataImage.image = dataImage.image!.withRenderingMode(.alwaysTemplate)
        dataImage.tintColor = UIColor.init(red: 235, green: 52, blue: 55)
    }
    
    func updateMenuParentCorner(_ b: Bool) {
        if b {
            containerView.roundCorners([.bottomLeft, .bottomRight], radius: 0)
            menuParentImageView.image = UIImage(named: "menu-parent-open")
            lineView.isHidden = false
        } else {
            containerView.roundCorners([.bottomLeft, .bottomRight], radius: 5)
            menuParentImageView.image = UIImage(named: "menu-parent-close")
            lineView.isHidden = true
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        if selected {
            print(label.text)
        } else {
            print(label.text! + " false")
        }
        
    }
}
