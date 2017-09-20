//
//  NavBar.swift
//  WongYiuNam-Doctor
//
//  Created by Admin on 9/12/17.
//  Copyright © 2017 RTH. All rights reserved.
//

import UIKit
enum leftNavBar {
    case back
    case menu
    case none
}
enum rightNavBar {
    case logout
    case DrInfo
    case none
}
protocol NavBarProtocol {
    func backPressed()
    func menuPressed()
    func logoutPressed()
}
@IBDesignable
class NavBar: UIView {
    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var constraintWidthICLeft: NSLayoutConstraint!
    @IBOutlet weak var constraintHeightICLeft: NSLayoutConstraint!
    @IBOutlet weak var icLeft : UIImageView!
    @IBOutlet weak var viewLeft : UIView!
    @IBOutlet weak var icRight: UIImageView!
    @IBOutlet weak var viewRight: UIView!
    @IBOutlet weak var lbName: UILabel!
    
    @IBInspectable var leftNavBar : leftNavBar = .none {
        didSet{
            changeStyle()
        }
    }
    var delegate:NavBarProtocol?
    @IBInspectable var rightNavBar : rightNavBar = .none {
        didSet{
            changeStyle()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func changeStyle(){
        switch leftNavBar {
        case .back:
            viewLeft.isHidden = false
            icLeft.image = #imageLiteral(resourceName: "ic_back")
            constraintWidthICLeft.constant = frame.width * 0.032
            constraintHeightICLeft.constant = constraintWidthICLeft.constant * 20 / 12
            viewLeft.gestureRecognizers?.forEach(viewLeft.removeGestureRecognizer(_:))
            viewLeft.addGestureRecognizer(UIGestureRecognizer(target: self, action: #selector(backPressed(_:))))
        case .menu:
            viewLeft.isHidden = false
            icLeft.image = #imageLiteral(resourceName: "ic_menu")
            constraintWidthICLeft.constant = frame.width * 0.04
            constraintHeightICLeft.constant = constraintWidthICLeft.constant
            viewLeft.gestureRecognizers?.forEach(viewLeft.removeGestureRecognizer(_:))
            viewLeft.addGestureRecognizer(UIGestureRecognizer(target: self, action: #selector(menuPressed(_:))))
        default:
            viewLeft.isHidden = true
        }
        switch rightNavBar {
        case .logout:
            viewRight.isHidden = false
            lbName.isHidden = true
            icRight.isHidden = false
            viewRight.gestureRecognizers?.forEach(viewLeft.removeGestureRecognizer(_:))
            viewRight.addGestureRecognizer(UIGestureRecognizer(target: self, action: #selector(logoutPressed(_:))))
        case .DrInfo:
            viewRight.isHidden = false
            lbName.isHidden = false
            icRight.isHidden = true
            viewRight.gestureRecognizers?.forEach(viewLeft.removeGestureRecognizer(_:))
        default:
            viewRight.isHidden = true
        }
    }
    
    private func commonInit(){
        Bundle.main.loadNibNamed("NavBar", owner: self, options: nil)

        addSubview(contentView)
        contentView.frame = self.bounds
        
        
    }
    
    @objc private func backPressed(_ sender: AnyObject){
        delegate?.backPressed()
    }
    
    @objc private func menuPressed(_ sender: AnyObject){
        delegate?.menuPressed()
    }
    @objc private func logoutPressed(_ sender: AnyObject){
        delegate?.logoutPressed()
    }
    
}
