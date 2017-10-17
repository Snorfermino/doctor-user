//
//  UploadPrescriptionViewController.swift
//  WongYiuNam-User
//
//  Created by Admin on 9/7/17.
//  Copyright © 2017 RTH. All rights reserved.
//

import UIKit

class UploadPrescriptionViewController: UIViewController, UINavigationControllerDelegate {

    @IBOutlet weak var contactNumberTextField: UITextField!
    @IBOutlet weak var addACommentTextField: UITextField!
    @IBOutlet weak var pdpaCheckBoxButton: CheckBoxButton!
    @IBOutlet weak var imageImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    func setupUI() {
        contactNumberTextField.borderStyle = .none
        addACommentTextField.borderStyle = .none
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem(title: "Upload Prescription")
    }
    
    @IBAction func attachPhotoButton(_ sender: Any) {
        let camera = Camera(delegate_: self)
        camera.presentPhotoLibrary(self, canEdit: true)
    }
    
    @IBAction func takePhotoButton(_ sender: Any) {
        let camera = Camera(delegate_: self)
        camera.presentPhotoCamera(self, canEdit: true)
    }
    
    
    @IBAction func submitButtonClicked(_ sender: Any) {
    
    }
}

extension UploadPrescriptionViewController: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerEditedImage] as! UIImage
        imageImageView.image = image
        picker.dismiss(animated: true, completion: nil)
    }
}








