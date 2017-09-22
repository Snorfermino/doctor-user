//
//  CheckBoxButton.swift
//  FM-Net
//
//  Created by Thuannq on 4/29/16.
//  Copyright © 2016 Bravesoft-Vn. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class CheckBoxButton: UIButton {
    
    fileprivate let disposeBag = DisposeBag()
    
    override var isSelected: Bool {
        didSet{
            let image = isSelected ? #imageLiteral(resourceName: "ic_check_on") : #imageLiteral(resourceName: "ic_check")
            setBackgroundImage(image, for: .normal)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.rx.tap
            .subscribe(onNext: { [unowned self] in
                self.isSelected = !self.isSelected
            })
            .disposed(by: disposeBag)
    }
}
