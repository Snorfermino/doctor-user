//
//  UIImageExtension.swift
//  WongYiuNam-Doctor
//
//  Created by Admin on 10/2/17.
//  Copyright © 2017 RTH. All rights reserved.
//

import Foundation
import SDWebImage

//MARK: SDWebImage quick access
extension UIImageView {
    func downloadImageAndCacheToMemory(_ url: String?, placeHolder: UIImage? = nil, needAuthen: Bool = true, completeBlock: SDWebImageDownloaderCompletedBlock? = nil) {
        if url?.isEmpty != false {
            print("downloadImageAndCacheToMemory-ERROR \(String(describing: url))")
            return
        }
        
        print("URL-TEST: \(url!)")
        if let urlRequest = URL(string: url!) {
            print("downloadImageAndCacheToMemory \(url!)")
            
//            updateHeaderSDWebImage(needAuthen)
            
            sd_setImage(with: urlRequest, placeholderImage: placeHolder, options: [.retryFailed], progress: { (receivedSize, expectedSize, _) in
                print("receivedSize \(receivedSize) expectedSize \(expectedSize)")
            }, completed: { (image, error, cacheType, url) in
                print("image \(String(describing: image)) error \(String(describing: error)) cacheType \(cacheType) url \(String(describing: url)))")
            })
        }
    }
    
    func downloadImageAndCacheToRam(_ url: String?, placeHolder: UIImage? = nil, needAuthen: Bool = true, completeBlock: SDWebImageDownloaderCompletedBlock? = nil) {
        
        if url?.isEmpty != false {
            print("downloadImageAndCacheToRam-ERROR \(url)")
            return
        }
        
//        updateHeaderSDWebImage(needAuthen)
        
        if let urlRequest = URL(string: url!) {
            print("downloadImageAndCacheToRam \(url!)")
            
            sd_setImage(with: urlRequest, placeholderImage: placeHolder, options: [.retryFailed], progress: { (receivedSize, expectedSize,_) in
                //                print("receivedSize \(receivedSize) expectedSize \(expectedSize)")
            }, completed: { (image, error, cacheType, url) in
                print("image \(String(describing: image)) error \(String(describing: error)) cacheType \(cacheType) url \(String(describing: url)))")
            })
        }
    }
    
    
    static func updateHeaderSDWebImage(_ needAuthen: Bool) {
//        if needAuthen {
//            if let token = Session.shareInstance.token {
//                //TO-DO: Image Header
//                SDWebImageDownloader.shared().setValue("", forHTTPHeaderField: "")
//            }
//        } else {
//            SDWebImageDownloader.shared().setValue("", forHTTPHeaderField: "")
//        }
    }
}
