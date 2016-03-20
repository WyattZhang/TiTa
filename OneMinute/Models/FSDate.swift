//
//  FSDate.swift
//  OneMinute
//
//  Created by Q on 16/3/17.
//  Copyright © 2016年 zwq. All rights reserved.
//

import Foundation
import CoreData


class FSDate: NSManagedObject {

// Insert code here to add functionality to your managed object subclass

    func dayOfDate() -> NSInteger {
        let date = NSDate(timeIntervalSinceReferenceDate: self.date)
        return date.day
    }
    
}
