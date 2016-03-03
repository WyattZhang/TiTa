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
    
    struct BeginDate {
        var birthYear = 0
        var year = 0
        var month = 0
        var day = 0
        var hour = 0
    }
    
    private var beginDate = BeginDate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSevenYearsList()
        self.tableView.separatorStyle = .None
        self.navigationController!.navigationBar.barStyle = .Black
        self.navigationController!.navigationBar.translucent = false
        self.tableView.backgroundColor = UIColor.blackColor()
        self.tableView.reloadData()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let authVC = storyBoard.instantiateViewControllerWithIdentifier("TouchIDAuthViewController") as! TouchIDAuthViewController
        let app = UIApplication.sharedApplication().delegate as! AppDelegate
        if !app.isAuthed {
            authVC.parentVC = self
            self.presentViewController(authVC, animated: false, completion: nil)
        }
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
        
        let sevenYears: SevenYears = sevenYearsList[indexPath.row]
        
        cell.layoutMargins = UIEdgeInsetsZero
        cell.lifeLabel.text = "\(indexPath.row + 1)"
        cell.ageLabel.text = "\(sevenYears.beginDayOfSevenYears.year - beginDate.birthYear) - \(sevenYears.endDayOfSevenYears.year - beginDate.birthYear)"
        cell.yearsLabel.text = "\(sevenYears.beginDayOfSevenYears.year) ~ \(sevenYears.endDayOfSevenYears.year)"
        
        let elapsedDays = sevenYears.elapsedDays()
        let totalDays = sevenYears.totalDays()
        let remainedPercentage: Float = 1.0 - Float(elapsedDays) / Float(totalDays)
        
        cell.totalDaysLabel.text = "\(totalDays) Days"
        cell.elapsedDaysLabel.text = "Elapsed : \(elapsedDays)"
        cell.remainDaysLabel.text = "Remain : \(sevenYears.remainDays())"

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
        
        cell.backgroundColor = UIColor.whiteColor()
        cell.backgroundColor = sevenYears.cellBackgroundColor
        
        return cell
    }
    
    
    func configureSevenYearsList() {
        
        beginDate.birthYear = 1984
        beginDate.year = 2002
        beginDate.month = 07
        beginDate.day = 04
        beginDate.hour = 24
        
        
        let sevenYears1 = SevenYears()
        sevenYears1.beginDayOfSevenYears = NSDate(year: beginDate.year, month: beginDate.month, day: beginDate.day, hour:beginDate.hour)
        sevenYears1.endDayOfSevenYears = NSDate(year: beginDate.year + 7, month: beginDate.month, day: beginDate.day, hour:beginDate.hour)
        sevenYears1.cellBackgroundColor = UIColor(rgba: 0x4AB8D2AA)
        
        let sevenYears2 = SevenYears()
        sevenYears2.beginDayOfSevenYears = sevenYears1.endDayOfSevenYears
        sevenYears2.endDayOfSevenYears = NSDate(year: sevenYears2.beginDayOfSevenYears.year + 7, month: beginDate.month, day: beginDate.day, hour:beginDate.hour)
        sevenYears2.cellBackgroundColor = UIColor(rgba: 0x58CF7EAA)

        
        let sevenYears3 = SevenYears()
        sevenYears3.beginDayOfSevenYears = sevenYears2.endDayOfSevenYears
        sevenYears3.endDayOfSevenYears = NSDate(year: sevenYears3.beginDayOfSevenYears.year + 7, month: beginDate.month, day: beginDate.day, hour:beginDate.hour)
        sevenYears3.cellBackgroundColor = UIColor(rgba: 0x327973AA)

        
        let sevenYears4 = SevenYears()
        sevenYears4.beginDayOfSevenYears = sevenYears3.endDayOfSevenYears
        sevenYears4.endDayOfSevenYears = NSDate(year: sevenYears4.beginDayOfSevenYears.year + 7, month: beginDate.month, day: beginDate.day, hour:beginDate.hour)
        sevenYears4.cellBackgroundColor = UIColor(rgba: 0xECB830AA)


        let sevenYears5 = SevenYears()
        sevenYears5.beginDayOfSevenYears = sevenYears4.endDayOfSevenYears
        sevenYears5.endDayOfSevenYears = NSDate(year: sevenYears5.beginDayOfSevenYears.year + 7, month: beginDate.month, day: beginDate.day, hour:beginDate.hour)
        sevenYears5.cellBackgroundColor = UIColor(rgba: 0xD25A23AA)


        let sevenYears6 = SevenYears()
        sevenYears6.beginDayOfSevenYears = sevenYears5.endDayOfSevenYears
        sevenYears6.endDayOfSevenYears = NSDate(year: sevenYears6.beginDayOfSevenYears.year + 7, month: beginDate.month, day: beginDate.day, hour:beginDate.hour)
        sevenYears6.cellBackgroundColor = UIColor(rgba: 0xAE2521AA)


        sevenYearsList = [sevenYears1, sevenYears2, sevenYears3, sevenYears4, sevenYears5, sevenYears6]
    }
    
}
