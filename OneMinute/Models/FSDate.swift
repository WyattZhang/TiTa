//
//  FSDate.swift
//  OneMinute
//
//  Created by Q on 16/3/17.
//  Copyright © 2016年 zwq. All rights reserved.
//

import UIKit

class FSDate: NSObject {
    
    var date: NSDate = NSDate()
    var hasCircle: Bool = false
    var numberOfEvents: Int = 0
    
    func dayOfDate() -> Int {
        return self.date.day
    }
}
