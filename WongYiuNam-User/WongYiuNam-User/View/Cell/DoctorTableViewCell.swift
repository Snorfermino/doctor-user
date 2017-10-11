//
//  DoctorTableViewCell.swift
//  WongYiuNam-User
//
//  Created by Admin on 10/8/17.
//  Copyright © 2017 RTH. All rights reserved.
//

import UIKit

class DoctorTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarButton: UIButton!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var specialityLabel: UILabel!
    @IBOutlet weak var experianceLabel: UILabel!
    @IBOutlet weak var speakingLanguageLabel: UILabel!
    
    var doctor: Doctor!
    
    func setup(doctor: Doctor) {
        self.doctor = doctor
        //avatarImageView.sd_setImage(with: doctor.avatar, completed: nil)
        if(doctor.online == false) {
            statusView.backgroundColor = UIColor.red
        }
        nameLabel.text = doctor.name
        if let speciality = doctor.speciality {
            specialityLabel.text = "Speciality: " + speciality
        }
        if let experience = doctor.experience {
            experianceLabel.text = "Experiance: " + experience
        }
        if let speakingLang = doctor.speakingLang {
            speakingLanguageLabel.text = "Speaking Language: " + speakingLang
        }
        if let isFavorite = doctor.isFavourite {
            if isFavorite == false {
                favoriteButton.backgroundColor = UIColor.black
                return
            }
        }
        favoriteButton.backgroundColor = UIColor.init(hex: "FFFFFF", alpha: 0.0)
    }
    
    @IBAction func likeButtonClicked(sender: Any) {
        let completion = {(error: String?) -> Void in
            print(error)
        }
        if let isFavourite = doctor.isFavourite {
            if isFavourite == false {
                favoriteButton.backgroundColor = UIColor.init(hex: "FFFFFF", alpha: 0.0)
                ApiManager.saveFavoritesDoctors(doctorId: doctor.id!, completion: completion)
                return
            }
        }
        ApiManager.deleteFavoritesDoctors(doctorId: doctor.id!, completion: completion)
        favoriteButton.backgroundColor = UIColor.black
    }
}
