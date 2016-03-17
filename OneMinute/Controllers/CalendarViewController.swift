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
    
    let fsDate = FSDate()
    var fsDates = [FSDate]()
    var oneMinute: OneMinute = OneMinute()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventTableView.backgroundColor = UIColor.lightGrayColor()
        self.configureNavigationBar()
        calendar.scrollDirection = .Horizontal
        calendar.appearance.caseOptions = [.HeaderUsesUpperCase,.WeekdayUsesUpperCase]
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
    
    func calendar(calendar: FSCalendar!, numberOfEventsForDate date: NSDate!) -> Int {

        if calendar.dayOfDate(date) == fsDate.dayOfDate() {
            return fsDate.numberOfEvents
        }
        
        return 0
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
}

extension CalendarViewController: OneMinuteViewControllerDelegate {
    func oneMinuteViewController(viewController: OneMinuteViewController, didFinishTiming oneMinute: OneMinute) {
        self.oneMinute = oneMinute
        eventTableView.reloadData()
    }
}

extension CalendarViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        switch indexPath.row {
        case 0:
            cell.textLabel!.text = " + Circle"
        case 1:
            cell.textLabel!.text = " - Circle"
        case 2:
            cell.textLabel!.text = " + Event"
        default:
            cell.textLabel!.text = " - Event"
        }

        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        switch indexPath.row {
        case 0:
            fsDate.hasCircle = true
        case 1:
            fsDate.hasCircle = false
        case 2:
            fsDate.numberOfEvents++
        default:
            fsDate.numberOfEvents--
        }

        calendar.reloadData()
    }
    
}

extension CalendarViewController: FSCalendarDelegateAppearance {
    
    func calendar(calendar: FSCalendar!, appearance: FSCalendarAppearance!, borderDefaultColorForDate date: NSDate!) -> UIColor! {
        
        guard calendar.dayOfDate(date) == fsDate.dayOfDate() && fsDate.hasCircle == true else {
            return appearance.borderDefaultColor
        }
        
        return UIColor.greenColor()
    }
}





