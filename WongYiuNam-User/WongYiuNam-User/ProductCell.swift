//
//  ProductCell.swift
//  WongYiuNam-User
//
//  Created by Admin on 9/20/17.
//  Copyright © 2017 RTH. All rights reserved.
//

import UIKit
protocol ProductCellProtocol {
    func addToCart()
}

class ProductCell: UITableViewCell {
    
    @IBOutlet weak var lbProductName:UILabel!
    @IBOutlet weak var lbPrice:UILabel!
    @IBOutlet weak var imgViewProduct:UIImageView!
    
    var productID:String = ""
    var delegate: ProductCellProtocol?
    
    @IBAction func addToCard(_ sender: UIButton) {
        delegate?.addToCart()
    }
}
