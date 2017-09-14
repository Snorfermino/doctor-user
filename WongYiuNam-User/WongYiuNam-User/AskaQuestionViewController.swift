//
//  AskaQuestionViewController.swift
//  WongYiuNam-User
//
//  Created by Admin on 9/11/17.
//  Copyright © 2017 RTH. All rights reserved.
//

import UIKit
import LTHRadioButton

class AskaQuestionViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var maleRatioButtonView: UIView!
    @IBOutlet weak var femaleRatioButtonView: UIView!
    @IBOutlet weak var chooseSexView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    func initUI() {
        let maleRadioButton = LTHRadioButton(selectedColor: UIColor(red: 209/255, green: 181/255, blue: 150/255, alpha: 1.0))
        let femaleRadioButton = LTHRadioButton(selectedColor: UIColor(red: 209/255, green: 181/255, blue: 150/255, alpha: 1.0))
        maleRadioButton.select()
        maleRatioButtonView.addSubview(maleRadioButton)
        var flag = true
        var flag2 = true
        maleRadioButton.onSelect {
            if(flag2) {
                flag = false
                femaleRadioButton.deselect()
            } else {
                flag2 = true
            }
        }
        maleRadioButton.onDeselect {
            if(flag) {
                flag2 = false
                maleRadioButton.select()
            } else {
                flag = true
            }
        }
        
        femaleRatioButtonView.addSubview(femaleRadioButton)
        femaleRadioButton.onSelect {
            if(flag2) {
                flag = false
                maleRadioButton.deselect()
            } else {
                flag2 = true
            }
        }
        femaleRadioButton.onDeselect {
            if(flag) {
                flag2 = false
                femaleRadioButton.select()
            } else {
                flag = true
            }
        }
    }
    
    @IBAction func attachPhotoButton(_ sender: Any) {
        let camera = Camera(delegate_: self)
        camera.presentPhotoLibrary(self, canEdit: true)
    }
    
    @IBAction func takePhotoButton(_ sender: Any) {
        let camera = Camera(delegate_: self)
        camera.presentPhotoCamera(self, canEdit: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print("finish picking image")
    }
}




