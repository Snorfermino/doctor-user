//
//  Date.swift
//  WongYiuNam-User
//
//  Created by Admin on 10/12/17.
//  Copyright © 2017 RTH. All rights reserved.
//

import Foundation

extension Date {
    
    func toString(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
