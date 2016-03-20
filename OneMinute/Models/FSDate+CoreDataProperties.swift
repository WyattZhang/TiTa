//
//  FSDate+CoreDataProperties.swift
//  OneMinute
//
//  Created by Q on 16/3/21.
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
    @NSManaged var subtitleChar1: String
    @NSManaged var subtitleChar2: String
    @NSManaged var subtitleChar3: String
    @NSManaged var subtitleChar4: String
    @NSManaged var subtitleChar5: String

}
