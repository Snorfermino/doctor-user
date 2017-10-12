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
        
        //Demo call api
        _ = {(newToken: String, error: String?) -> Void in
            print(newToken)
        }
        //ApiManager.changePassword(oldPassword: "nhatduy", newPassword: "54321", completion: completion)
        var user = User()
        user.name = "ABC"
        user.email = "bb@gmail.com"
        let completion = {(result: String?) -> Void in
            print(result)
        }
        ApiManager.updateUserProfile(user: user, completion: completion)
        //demo call api
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
    
    @IBAction func uploadPrescriptionButtonClicked(_ sender: Any) {
        NotificationCenter.default.post(name: Notification.Name("ChangeMenuTab"), object: "UploadPrescription")
    }
    
    @IBAction func socialWallButtonClicked(_ sender: Any) {
        NotificationCenter.default.post(name: Notification.Name("ChangeMenuTab"), object: "SocialWall")
    }
    
    @IBAction func onlineShopButtonClicked(_ sender: Any) {
        NotificationCenter.default.post(name: Notification.Name("ChangeMenuTab"), object: "OnlineShop")
    }
    
    @IBAction func askaDoctorButtonClicked(_ sender: Any) {
        NotificationCenter.default.post(name: Notification.Name("ChangeMenuTab"), object: "AskaDoctor")
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
