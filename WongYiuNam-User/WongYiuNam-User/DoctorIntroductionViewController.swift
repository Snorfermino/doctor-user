//
//  DoctorIntroductionViewController.swift
//  WongYiuNam-User
//
//  Created by Admin on 9/11/17.
//  Copyright © 2017 RTH. All rights reserved.
//

import UIKit

class DoctorIntroductionViewController: UIViewController {
    @IBOutlet weak var monScheduleView: UIView!
    @IBOutlet weak var tueScheduleView: UIView!
    @IBOutlet weak var wedScheduleView: UIView!
    @IBOutlet weak var thuScheduleView: UIView!
    @IBOutlet weak var friScheduleView: UIView!
    @IBOutlet weak var satScheduleView: UIView!
    @IBOutlet weak var sunScheduleView: UIView!

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var specialtyLabel: UILabel!
    @IBOutlet weak var qualificationsLabel: UILabel!
    @IBOutlet weak var introductionLabel: UILabel!
    var doctor: Doctor!
    
    let scheduleData = [(day: "MON", status: false), (day: "TUE", status: true), (day: "WED", status: false), (day: "THU", status: true),
                        (day: "FRI", status: true), (day: "SAT", status: false), (day: "SUN", status: false)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showDoctor()
        setupSchedule()
    }

    func showDoctor() {
//        avatarImageView.makeCircular()
//        avatarImageView.layer.borderWidth = 1
//        avatarImageView.layer.borderColor = UIColor(hex: "DAC1A8").cgColor
//        avatarImageView.layer.shadowColor = UIColor.black.cgColor
//        avatarImageView.layer.shadowOpacity = 1
//        avatarImageView.layer.shadowOffset = CGSize.zero
//        avatarImageView.layer.shadowRadius = avatarImageView.frame.height/2
        nameLabel.text = doctor.name
        specialtyLabel.text = doctor.specialty
        qualificationsLabel.text = doctor.qualifications
        introductionLabel.text = doctor.introduction
    }
    
    func setupSchedule() {
        let listView = [monScheduleView, tueScheduleView, wedScheduleView, thuScheduleView,
                        friScheduleView, satScheduleView, sunScheduleView]
        for idx in 0..<7 {
            setupDay(view: listView[idx]!, data: scheduleData[idx])
        }
    }
    
    func setupDay(view: UIView, data: (day: String, status: Bool)) {
        let dayView = DayInScheduleView(frame: view.bounds)
        dayView.setup(day: data.day, status: data.status)
        view.addSubview(dayView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
