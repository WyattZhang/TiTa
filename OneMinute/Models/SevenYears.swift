//
//  SevenYears.swift
//  OneMinute
//
//  Created by Q on 16/3/2.
//  Copyright © 2016年 zwq. All rights reserved.
//

import UIKit

class SevenYears: NSObject {

    var beginDayOfSevenYears: NSDate = NSDate()
    var endDayOfSevenYears: NSDate = NSDate()
 
    func totalDays() -> Int {
        let cal = NSCalendar.currentCalendar()
        let unit: NSCalendarUnit = .Day
        let components = cal.components(unit, fromDate: self.beginDayOfSevenYears, toDate: self.endDayOfSevenYears, options:[])
        
        return components.day
    }
    
    func elapsedDays() -> Int {
        let today = NSDate()
        let cal = NSCalendar.currentCalendar()
        let unit: NSCalendarUnit = .Day
        let components = cal.components(unit, fromDate: self.beginDayOfSevenYears, toDate: today, options:[])
        if components.day < 0  {
            return 0
        } else if components.day <= totalDays() {
            return components.day
        } else {
            return totalDays()
        }
    }
    
    func remainDays() -> Int {
        return self.totalDays() - self.elapsedDays()
    }
}
