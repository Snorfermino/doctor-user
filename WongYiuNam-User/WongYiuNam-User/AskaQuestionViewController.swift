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
    @IBOutlet weak var chooseSexView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let radioButton = LTHRadioButton(selectedColor: .red)
        chooseSexView.addSubview(radioButton)
        
        radioButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            radioButton.centerYAnchor.constraint(equalTo: chooseSexView.centerYAnchor),
            radioButton.leadingAnchor.constraint(equalTo: chooseSexView.leadingAnchor, constant: 16),
            radioButton.heightAnchor.constraint(equalToConstant: radioButton.frame.height),
            radioButton.widthAnchor.constraint(equalToConstant: radioButton.frame.width)]
        )
        radioButton.onSelect {
            print("I'm selected.")
        }
        radioButton.onDeselect {
            print("I'm deselected.")
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




