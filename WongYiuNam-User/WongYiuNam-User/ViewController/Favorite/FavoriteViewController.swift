//
//  FavoriteViewController.swift
//  WongYiuNam-User
//
//  Created by Admin on 10/9/17.
//  Copyright © 2017 RTH. All rights reserved.
//

import UIKit
import SJSegmentedScrollView

class FavoriteViewController: SJSegmentedViewController {

    var selectedSegment: SJSegmentTab?
    
    override func viewDidLoad() {
        if let storyboard = self.storyboard {
            
            //let headerController = storyboard.instantiateViewController(withIdentifier: "HeaderViewController1")
            
            let itemViewController = storyboard.instantiateViewController(withIdentifier: "FavoriteItemViewController") as! FavoriteItemViewController
            itemViewController.title = "Items"
            
            let doctorViewController = storyboard.instantiateViewController(withIdentifier: "FavoriteDoctorViewController") as! FavoriteDoctorViewController
            doctorViewController.title = "Doctors"
            
            let questionViewController = storyboard.instantiateViewController(withIdentifier: "FavoriteQuestionViewController") as! FavoriteQuestionViewController
            questionViewController.title = "Questions"
            
            let answerViewController = storyboard.instantiateViewController(withIdentifier: "FavoriteAnswerViewController") as! FavoriteAnswerViewController
            answerViewController.title = "Answers"
            
            segmentControllers = [itemViewController,
                                  doctorViewController,
                                  questionViewController,
                                  answerViewController]
            //headerViewHeight = -100.0
            selectedSegmentViewHeight = 4.0
            //headerViewOffsetHeight = 31.0
            segmentTitleColor = .gray
            selectedSegmentViewColor = .red
            segmentShadow = SJShadow.light()
            showsHorizontalScrollIndicator = false
            showsVerticalScrollIndicator = false
            delegate = self
        }
        super.viewDidLoad()
    }
    
    func getSegmentTabWithImage(_ imageName: String) -> UIView {
        let view = UIImageView()
        view.frame.size.width = 50
        view.image = UIImage(named: imageName)
        view.contentMode = .scaleAspectFit
        view.backgroundColor = .white
        return view
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem(title: "My Favourites")
    }
}

extension FavoriteViewController: SJSegmentedViewControllerDelegate {
    
    func didMoveToPage(_ controller: UIViewController, segment: SJSegmentTab?, index: Int) {
        if selectedSegment != nil {
            selectedSegment?.titleColor(.lightGray)
        }
        if segments.count > 0 {
            selectedSegment = segments[index]
            selectedSegment?.titleColor(.red)
        }
    }
}
