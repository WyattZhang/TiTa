//
//  SevenYearsTableViewController.swift
//  OneMinute
//
//  Created by Q on 16/3/1.
//  Copyright © 2016年 zwq. All rights reserved.
//

import UIKit

class SevenYearsTableViewController: UITableViewController {

    private var sevenYearsList = [SevenYears]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSevenYearsList()
        self.tableView.separatorStyle = .None
        self.navigationController!.navigationBar.barStyle = .Black
        self.navigationController!.navigationBar.translucent = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return sevenYearsList.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SevenYearsTableViewCell", forIndexPath: indexPath) as! SevenYearsTableViewCell
        
        configureCell(cell, withIndexPaht: indexPath)
        
        return cell
    }

}

extension SevenYearsTableViewController {
    
    func configureCell(cell: SevenYearsTableViewCell, withIndexPaht indexPath: NSIndexPath) -> SevenYearsTableViewCell {
        
        cell.layoutMargins = UIEdgeInsetsZero
        cell.lifeLabel.text = "Life \(indexPath.row + 1): " + "\(sevenYearsList[indexPath.row].beginDayOfSevenYears.year - 1984) - \(sevenYearsList[indexPath.row].endDayOfSevenYears.year - 1984)"
        cell.yearsLabel.text = "\(sevenYearsList[indexPath.row].beginDayOfSevenYears.year) ~ \(sevenYearsList[indexPath.row].endDayOfSevenYears.year)"
        
        let elapsedDays = sevenYearsList[indexPath.row].elapsedDays()
        let totalDays = sevenYearsList[indexPath.row].totalDays()
        let remainedPercentage: Float = 1.0 - Float(elapsedDays) / Float(totalDays)
        
        cell.totalDaysLabel.text = "Total Days: \(totalDays)"
        cell.elapsedDaysLabel.text = "Elapsed Days: \(elapsedDays)"
        cell.remainDaysLabel.text = "Remain Days: \(sevenYearsList[indexPath.row].remainDays())"

        let remainedPercentageToDisplay: String
        switch remainedPercentage {
        case 0.0:
            remainedPercentageToDisplay = "0%"
        case 1.0:
            remainedPercentageToDisplay = "100%"
        default:
            remainedPercentageToDisplay = String(format: "%.2f%%", remainedPercentage*100)
        }
        
        cell.remainedPercentageLabe.text = remainedPercentageToDisplay
        cell.progressView.progress = remainedPercentage
        
        return cell
    }
    
    
    func configureSevenYearsList() {
        
        let sevenYears1 = SevenYears()
        sevenYears1.beginDayOfSevenYears = NSDate(year: 2002, month: 07, day: 04, hour:24)
        sevenYears1.endDayOfSevenYears = NSDate(year: 2009, month: 07, day: 04, hour:24)
        
        let sevenYears2 = SevenYears()
        sevenYears2.beginDayOfSevenYears = NSDate(year: 2009, month: 07, day: 04, hour:24)
        sevenYears2.endDayOfSevenYears = NSDate(year: 2016, month: 07, day: 04, hour:24)
        
        let sevenYears3 = SevenYears()
        sevenYears3.beginDayOfSevenYears = NSDate(year: 2016, month: 07, day: 04, hour:24)
        sevenYears3.endDayOfSevenYears = NSDate(year: 2023, month: 07, day: 04, hour:24)
        
        let sevenYears4 = SevenYears()
        sevenYears4.beginDayOfSevenYears = NSDate(year: 2023, month: 07, day: 04, hour:24)
        sevenYears4.endDayOfSevenYears = NSDate(year: 2030, month: 07, day: 04, hour:24)

        let sevenYears5 = SevenYears()
        sevenYears5.beginDayOfSevenYears = NSDate(year: 2030, month: 07, day: 04, hour:24)
        sevenYears5.endDayOfSevenYears = NSDate(year: 2037, month: 07, day: 04, hour:24)

        let sevenYears6 = SevenYears()
        sevenYears6.beginDayOfSevenYears = NSDate(year: 2037, month: 07, day: 04, hour:24)
        sevenYears6.endDayOfSevenYears = NSDate(year: 2044, month: 07, day: 04, hour:24)

        sevenYearsList = [sevenYears1, sevenYears2, sevenYears3, sevenYears4, sevenYears5, sevenYears6]
    }
    
}
