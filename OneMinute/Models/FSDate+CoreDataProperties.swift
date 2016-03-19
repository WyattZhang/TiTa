//
//  FSDate+CoreDataProperties.swift
//  OneMinute
//
//  Created by Q on 16/3/18.
//  Copyright © 2016年 zwq. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension FSDate {

    @NSManaged var date: NSTimeInterval
    @NSManaged var hasCircle: Bool
    @NSManaged var numberOfEvents: Int16

}
