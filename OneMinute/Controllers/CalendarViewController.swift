//
//  CalendarViewController.swift
//  OneMinute
//
//  Created by Q on 16/3/4.
//  Copyright © 2016年 zwq. All rights reserved.
//

import UIKit

class CalendarViewController: UIViewController, FSCalendarDataSource, FSCalendarDelegate {
    
    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var calendarHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var eventTableView: CalendarTableView!
    
    var oneMinute: OneMinute = OneMinute()
    
    
    
    let datesWithCat = ["20150505","20150605","20150705","20150805","20150905","20151005","20151105","20151205","20160106","20160206","20160306","20160406","20160506","20160606","20160706"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureNavigationBar()
        
        
        self.eventTableView.allowsSelection = false
//        eventTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        calendar.scrollDirection = .Horizontal
        calendar.appearance.caseOptions = [.HeaderUsesUpperCase,.WeekdayUsesUpperCase]
        calendar.selectDate(calendar.dateWithYear(2016, month: 03, day: 6))
        
        
        //        calendar.allowsMultipleSelection = true
        
        // Uncomment this to test month->week and week->month transition
        
        //        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (Int64)(1.5 * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) { () -> Void in
        //            self.calendar.setScope(.Week, animated: true)
        //            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (Int64)(1.5 * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) { () -> Void in
        //                self.calendar.setScope(.Month, animated: true)
        //            }
        //        }
        
    }
    
    func configureNavigationBar() {
        self.navigationController!.navigationBar.barStyle = .Black
        self.navigationController!.navigationBar.translucent = false
        self.navigationController!.navigationBar.tintColor = UIColor.grayColor()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "SevenYears", style: UIBarButtonItemStyle.Plain, target: self, action: "showSevenYearsVC")
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "OneMinute", style: .Plain, target: self, action: "showOneMinuteVC")
    }
    
    func showSevenYearsVC() {
        let sevenYearsVC = self.storyboard!.instantiateViewControllerWithIdentifier("SevenYearsTableViewController")
        self.navigationController!.pushViewController(sevenYearsVC, animated: true)
    }
    
    func showOneMinuteVC() {
        let oneMinuteVC = self.storyboard!.instantiateViewControllerWithIdentifier("OneMinuteViewController") as! OneMinuteViewController
        oneMinuteVC.delegate = self
        self.navigationController!.pushViewController(oneMinuteVC, animated: true)
    }
    
//    func minimumDateForCalendar(calendar: FSCalendar!) -> NSDate! {
//        return calendar.dateWithYear(2015, month: 1, day: 1)
//    }
    
//    func maximumDateForCalendar(calendar: FSCalendar!) -> NSDate! {
//        return calendar.dateWithYear(2016, month: 10, day: 31)
//    }
    
    func calendar(calendar: FSCalendar!, numberOfEventsForDate date: NSDate!) -> Int {
        let day = calendar.dayOfDate(date)
        return day % 5 == 0 ? day/5 : 0;
    }
    
    func calendarCurrentPageDidChange(calendar: FSCalendar!) {
        NSLog("change page to \(calendar.stringFromDate(calendar.currentPage))")
    }
    
    func calendar(calendar: FSCalendar!, didSelectDate date: NSDate!) {
        NSLog("calendar did select date \(calendar.stringFromDate(date))")
        print(date)
    }
    
    func calendarCurrentScopeWillChange(calendar: FSCalendar!, animated: Bool) {
        calendarHeightConstraint.constant = calendar.sizeThatFits(CGSizeZero).height
        view.layoutIfNeeded()
    }
    
    func calendar(calendar: FSCalendar!, imageForDate date: NSDate!) -> UIImage! {
        return [13,24].containsObject(calendar.dayOfDate(date)) ? UIImage(named: "icon_cat") : nil
    }
    
}

extension CalendarViewController: OneMinuteViewControllerDelegate {
    func oneMinuteViewController(viewController: OneMinuteViewController, didFinishTiming oneMinute: OneMinute) {
        self.oneMinute = oneMinute
        eventTableView.reloadData()
    }
}


extension CalendarViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = eventTableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        cell.contentView.backgroundColor = UIColor.grayColor()
        cell.textLabel!.text = "\(oneMinute.startTime.fromNow?.year)"
        cell.detailTextLabel!.text = oneMinute.finishTime.toString()
        return cell
    }
    
}
