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

    let scheduleData = [(day: "MON", status: false), (day: "TUE", status: true), (day: "WED", status: false), (day: "THU", status: true),
                        (day: "FRI", status: true), (day: "SAT", status: false), (day: "SUN", status: false)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSchedule()
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
