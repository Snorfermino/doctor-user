//
//  SocialWallViewController.swift
//  WongYiuNam-User
//
//  Created by Admin on 9/6/17.
//  Copyright © 2017 RTH. All rights reserved.
//

import UIKit
import SDWebImage
import DRPLoadingSpinner
import UILoadControl

class SocialWallViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    //var data: [PostFB] = []
    var data: [VideoYT] = []
    let activityIndicatorView = DRPLoadingSpinner()
    var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        activityIndicatorView.initView(view: view)
        tableView.addSubview(activityIndicatorView)
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh), for: UIControlEvents.valueChanged)
        tableView.addSubview(refreshControl)
        //tableView.loadControl = UILoadControl(target: self, action: #selector(loadDataFacebook))
        //loadDataFacebook()
        tableView.loadControl = UILoadControl(target: self, action: #selector(loadDataYoutube))
        loadDataYoutube()
        tableView.tableFooterView = UIView(frame: .zero)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem(title: "Social Wall")
    }
    
    @objc func refresh() {
        //ApiManager.loadPostFBNextPage = nil
        //loadDataFacebook(refresh: true)
        ApiManager.videoYoutubeNextPage = nil
        loadDataYoutube(refresh: true)
    }
    
//    @objc func loadDataFacebook(refresh: Bool = false) {
//        let completion = {(data: [PostFB]?, error: String?) -> Void in
//            if(self.data.count == 0 && refresh == false) {
//                self.activityIndicatorView.stopAnimating()
//            } else if (refresh == false) {
//                self.tableView.loadControl?.endLoading()
//            } else {
//                self.refreshControl.endRefreshing()
//                self.data.removeAll()
//            }
//            guard let data = data else {
//                Utils.showAlert(title: "Error", message: error, viewController: self)
//                return
//            }
//            self.data.append(contentsOf: data)
//            self.tableView.reloadData()
//        }
//        if(data.count == 0 && refresh == false) {
//            activityIndicatorView.startAnimating()
//        }
//        ApiManager.getPostsFromFanpageFacebook(completion: completion)
//    }
    
    @objc func loadDataYoutube(refresh: Bool = false) {
        let completion = {(data: [VideoYT]?, error: String?) -> Void in
            if(self.data.count == 0 && refresh == false) {
                self.activityIndicatorView.stopAnimating()
            } else if (refresh == false) {
                self.tableView.loadControl?.endLoading()
            } else {
                self.refreshControl.endRefreshing()
                self.data.removeAll()
            }
            guard let data = data else {
                if let error = error {
                    Utils.showAlert(title: "Error", message: error, viewController: self)
                }
                return
            }
            self.data.append(contentsOf: data)
            self.tableView.reloadData()
        }
        if(data.count == 0 && refresh == false) {
            activityIndicatorView.startAnimating()
        }
        ApiManager.getVideosFromYoutubeChannel(completion: completion)
    }
}

extension SocialWallViewController: UITableViewDelegate {
    
}

extension SocialWallViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "postFBCell")!
//        let p = data[indexPath.row]
//        if let messageLabel = cell.viewWithTag(100) as? UILabel {
//            messageLabel.text = p.message
//        }
//        if let likesCount = cell.viewWithTag(101) as? UILabel {
//            likesCount.text = String(describing: p.likesCount)
//        }
//        if let commentsCount = cell.viewWithTag(102) as? UILabel {
//            commentsCount.text = String(describing: p.commentsCount)
//        }
//        if let attachmentImage = cell.viewWithTag(103) as? UIImageView {
//            attachmentImage.sd_setImage(with: p.attachmentImage, completed: nil)
//        }
//        return cell
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "videoYoutubeCell")!
        let p = data[indexPath.row]
        if let titleLabel = cell.viewWithTag(100) as? UILabel {
            titleLabel.text = p.title
        }
        if let descriptionLabel = cell.viewWithTag(101) as? UILabel {
            descriptionLabel.text = String(describing: p.description)
        }
        if let thumbnailImageView = cell.viewWithTag(102) as? UIImageView {
            thumbnailImageView.sd_setImage(with: p.thumbnail, completed: nil)
        }
        return cell
    }
}

extension SocialWallViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.loadControl?.update()
    }
}
