//
//  PatientPhotoViewController.swift
//  WongYiuNam-Doctor
//
//  Created by Admin on 10/5/17.
//  Copyright © 2017 RTH. All rights reserved.
//

import UIKit

class PatientPhotoViewController: BaseViewController {
    var photoImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
            setupView()
    }
    
    override func setupView(){
        super.setupView()
        setupNavBar(.none, .back, "")
        let imageView = photoImage
        photoImage = UIImageView(image: imageView?.image)
        let scrollView = UIScrollView(frame: self.view.frame)
        
        scrollView.frame = CGRect(x: 0, y: 65, width: self.view.frame.width, height: self.view.frame.height - 65)
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 6.0
        scrollView.delegate = self
        photoImage.backgroundColor = UIColor.white.withAlphaComponent(1)
        photoImage.contentMode = .scaleAspectFit
        photoImage.isUserInteractionEnabled = true
        photoImage.frame = scrollView.frame
        scrollView.addSubview(photoImage)
        self.view.addSubview(scrollView)
    }
    

}
extension PatientPhotoViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return photoImage
    }
}
