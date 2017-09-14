//
//  DayInScheduleView.swift
//  WongYiuNam-User
//
//  Created by Admin on 9/14/17.
//  Copyright © 2017 RTH. All rights reserved.
//

import UIKit

class DayInScheduleView: UIView {
    var view: UIView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var barView: UIView!
    @IBOutlet weak var saregoonLabel: UILabel!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initView()
    }
    
    func loadView() -> UIView{
        let bundle = Bundle(for:type(of: self))
        let nib = UINib(nibName: "DayInScheduleView", bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil)[0] as! UIView
    }
    
    func initView()
    {
        view = loadView()
        view.frame = self.bounds
        view.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        addSubview(view)
    }
    
    func setup(day: String, status: Bool) {
        dayLabel.text = day
        barView.layer.cornerRadius = barView.frame.height * 0.5
        setStatus(status)
    }
    
    func setStatus(_ status : Bool) {
        if(status) {
            dayLabel.textColor = UIColor(red: 217/255, green: 28/255, blue: 44/255, alpha: 1.0)
            barView.isHidden = false
            saregoonLabel.isHidden = false
        } else {
            dayLabel.textColor = UIColor(red: 137/255, green: 137/255, blue: 137/255, alpha: 1.0)
            barView.isHidden = true
            saregoonLabel.isHidden = true
        }
    }
}
