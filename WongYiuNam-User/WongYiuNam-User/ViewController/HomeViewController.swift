//
//  ViewController.swift
//  WongYiuNam-User
//
//  Created by Phat Chiem on 9/6/17.
//  Copyright © 2017 RTH. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift

class HomeViewController: UIViewController {
    
    @IBOutlet weak var sliderScrollView: UIScrollView!
    @IBOutlet weak var sliderPageControl: UIPageControl!
    @IBOutlet weak var uploadPrescriptionButton: UIButton!

    let listImages = ["home-bitmap", "1", "2", "3"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initSlider()
        loadSavedData()
    }
    
    func loadSavedData() {
        Global.user = DataManager.getUserInfo()
    }
    
    func initSlider() {
        sliderScrollView.isPagingEnabled = true
        sliderScrollView.contentSize = CGSize(width: view.bounds.width * CGFloat(listImages.count), height: 200)
        sliderScrollView.showsHorizontalScrollIndicator = false
        sliderScrollView.delegate = self
        for (idx, imageName) in listImages.enumerated() {
            let img = UIImageView(image: UIImage(named: imageName))
            sliderScrollView.addSubview(img)
            img.frame.origin.x = CGFloat(idx) * sliderScrollView.frame.size.width
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem()
    }
}

extension HomeViewController : SlideMenuControllerDelegate {
    
    func leftWillOpen() {
        print("SlideMenuControllerDelegate: leftWillOpen")
    }
    
    func leftDidOpen() {
        print("SlideMenuControllerDelegate: leftDidOpen")
    }
    
    func leftWillClose() {
        print("SlideMenuControllerDelegate: leftWillClose")
    }
    
    func leftDidClose() {
        print("SlideMenuControllerDelegate: leftDidClose")
    }
    
    func rightWillOpen() {
        print("SlideMenuControllerDelegate: rightWillOpen")
    }
    
    func rightDidOpen() {
        print("SlideMenuControllerDelegate: rightDidOpen")
    }
    
    func rightWillClose() {
        print("SlideMenuControllerDelegate: rightWillClose")
    }
    
    func rightDidClose() {
        print("SlideMenuControllerDelegate: rightDidClose")
    }
}

extension HomeViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = scrollView.contentOffset.x / scrollView.frame.size.width
        sliderPageControl.currentPage = Int(page)
    }
}
