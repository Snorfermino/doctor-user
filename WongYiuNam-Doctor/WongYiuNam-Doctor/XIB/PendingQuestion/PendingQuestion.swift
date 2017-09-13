//
//  PendingQuestion.swift
//  WongYiuNam-Doctor
//
//  Created by Admin on 9/13/17.
//  Copyright © 2017 RTH. All rights reserved.
//

import UIKit

class PendingQuestion: UIView {

    @IBOutlet weak var contentView:UIView!
    @IBOutlet weak var tvQuestion:UITextView!
    @IBOutlet weak var lbCreatedAt:UILabel!
    @IBOutlet weak var lbPatientName:UILabel!
    @IBOutlet weak var lbPatientGender:UILabel!
    @IBOutlet weak var lbPatientDOB:UILabel!
    @IBOutlet weak var imgViewPatientSubmit:UIImageView!
    @IBOutlet weak var btnRecordAnswer:UIButton!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    
    private func commonInit(){
        Bundle.main.loadNibNamed("PendingQuestion", owner: self, options: nil)
        
        addSubview(contentView)
        contentView.frame = self.bounds
        
        
    }
    
    func btnRecordPressed(_ sender: UIButton) {
        
    
    }
}
