//
//  CalendarViewController.swift
//  OneMinute
//
//  Created by Q on 16/3/4.
//  Copyright © 2016年 zwq. All rights reserved.
//

import UIKit
import CoreData

class CalendarViewController: UIViewController {
    
    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var calendarHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var eventTableView: CalendarTableView!
    
    lazy var managedContext: NSManagedObjectContext = {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext =  appDelegate.managedObjectContext
        return managedContext
    }()
    
    lazy var fsDate: FSDate = {
        return NSEntityDescription.insertNewObjectForEntityForName("FSDate", inManagedObjectContext: self.managedContext) as! FSDate
    }()
    
    var fsDates: [FSDate]!
    var daysOfFSDates: [NSTimeInterval]!
    var oneMinute: OneMinute = OneMinute()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureNavigationBar()
        self.configureCalendarApperance()
        self.loadFsDatesOfCurrentMonth()
        self.configureToday()
    }
    
    func configureCalendarApperance() {
        calendar.scrollDirection = .Horizontal
        calendar.appearance.cellShape = .Rectangle
        calendar.appearance.caseOptions = [.HeaderUsesDefaultCase,.WeekdayUsesDefaultCase]
    }
    
    func configureToday() {
        self.calendar.selectDate(self.calendar.today)
        let fetchRequest = NSFetchRequest(entityName: "FSDate")
        fetchRequest.predicate = NSPredicate(format: "date == %@", self.calendar.today)
        
        do {
            let results = try managedContext.executeFetchRequest(fetchRequest) as! [FSDate]
            if results.first != nil {
                fsDate = results.first!
            } else {
                fsDate = NSEntityDescription.insertNewObjectForEntityForName("FSDate", inManagedObjectContext: self.managedContext) as! FSDate
                fsDate.date = self.calendar.today.timeIntervalSinceReferenceDate
            }
        } catch let err as NSError {
            print("Error: \(err) " + "description \(err.localizedDescription)")
        }
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
    
}

// MARK: - FSCalendarDataSource FSCalendarDelegate

extension CalendarViewController: FSCalendarDataSource, FSCalendarDelegate {
    
    func calendarCurrentPageDidChange(calendar: FSCalendar!) {
        loadFsDatesOfCurrentMonth()
        self.calendar.reloadData()
    }
    
    func calendar(calendar: FSCalendar!, didSelectDate date: NSDate!) {
        
        guard let idx = daysOfFSDates.indexOf(date.timeIntervalSinceReferenceDate) else {
            
            fsDate = NSEntityDescription.insertNewObjectForEntityForName("FSDate", inManagedObjectContext: self.managedContext) as! FSDate
            self.fsDate.date = date.timeIntervalSinceReferenceDate
            print("new")
            return
        }
        
        fsDate = fsDates[idx]
        
        NSLog("calendar did select date \(calendar.stringFromDate(date))")
    }
    
    func calendar(calendar: FSCalendar!, numberOfEventsForDate date: NSDate!) -> Int {
        
        guard let idx = daysOfFSDates.indexOf(date.timeIntervalSinceReferenceDate) else {
            return 0
        }
        return Int(fsDates[idx].numberOfEvents)
    }
    
    func calendar(calendar: FSCalendar!, subtitleForDate date: NSDate!) -> String {
        guard let idx = daysOfFSDates.indexOf(date.timeIntervalSinceReferenceDate) else {
            return ""
        }
 
        return fsDates[idx].subtitleChar1 + fsDates[idx].subtitleChar2 + fsDates[idx].subtitleChar3 + fsDates[idx].subtitleChar4 + fsDates[idx].subtitleChar5
    }
}

// MARK: - FSCalendarDelegateAppearance

extension CalendarViewController: FSCalendarDelegateAppearance {
    
    func calendar(calendar: FSCalendar!, appearance: FSCalendarAppearance!, borderDefaultColorForDate date: NSDate!) -> UIColor! {
        
        guard let idx = daysOfFSDates.indexOf(date.timeIntervalSinceReferenceDate) else {
            return appearance.borderDefaultColor
        }
        
        return fsDates[idx].hasCircle ? UIColor(rgba: 0x35839DAA) : appearance.borderDefaultColor
    }
    
    func calendar(calendar: FSCalendar!, appearance: FSCalendarAppearance!, borderSelectionColorForDate date: NSDate!) -> UIColor! {
        
        guard let idx = daysOfFSDates.indexOf(date.timeIntervalSinceReferenceDate) else {
            return appearance.borderDefaultColor
        }
        
        return fsDates[idx].hasCircle ? UIColor.lightGrayColor() : appearance.borderDefaultColor
    }
}

extension CalendarViewController: OneMinuteViewControllerDelegate {
    func oneMinuteViewController(viewController: OneMinuteViewController, didFinishTiming oneMinute: OneMinute) {
        self.oneMinute = oneMinute
        eventTableView.reloadData()
    }
}

// MARK: - TableVeiw Delegate

extension CalendarViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        switch indexPath.row {
        case 0:
            cell.textLabel!.text = "Circle"
        case 1:
            cell.textLabel!.text = " + Event"
        case 2:
            cell.textLabel!.text = " - Event"
        case 3:
            cell.textLabel!.text = " Getup Mark"
        case 4:
            cell.textLabel!.text = " Walk Mark"
        case 5:
            cell.textLabel!.text = " Reading Mark"
        case 6:
            cell.textLabel!.text = " Sleep Mark"
        default:
            break
        }

        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        switch indexPath.row {
        case 0:
            fsDate.hasCircle = !fsDate.hasCircle
        case 1:
            if fsDate.numberOfEvents == 3 {
                return
            }
            fsDate.numberOfEvents++
        case 2:
            if fsDate.numberOfEvents == 0 {
                return
            }
            fsDate.numberOfEvents--
        case 3:
            markSubtitle(&fsDate.subtitleChar1, withCharacter: "G")
        case 4:
            markSubtitle(&fsDate.subtitleChar2, withCharacter: "W")
        case 5:
            markSubtitle(&fsDate.subtitleChar3, withCharacter: "R")
        case 6:
            markSubtitle(&fsDate.subtitleChar4, withCharacter: "S")
        default:
            break
        }
        
        updateDate()
        loadFsDatesOfCurrentMonth()
        calendar.reloadData()
        
        print("didsele dates",fsDates)
        print("didsele date",fsDate)
    }
    
}

// MARK: - CoreData
extension CalendarViewController {
    
    func loadFsDatesOfCurrentMonth() {
        
        let fromDate = calendar.beginingOfMonthOfDate(calendar.currentPage)
        let toDate = calendar.endOfMonthOfDate(calendar.currentPage)
        
        let request = NSFetchRequest(entityName: "FSDate")
        let predicate = NSPredicate(format: "date >= %@ && date <= %@ ", fromDate, toDate);
        request.predicate = predicate;
        
        do {
            let results = try managedContext.executeFetchRequest(request)
            fsDates = results as! [FSDate]
            daysOfFSDates = fsDates.map{$0.date}
        } catch {
            fatalError("fetch fsDates err")
        }
        print(fsDates.count, fromDate, toDate)
    }
    
    func updateDate() {
                
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save:\(error)")
        }
    }
    
    func markSubtitle(inout subtitle: String, withCharacter char: String) {
        
        if subtitle == " " {
            subtitle = char
        } else {
            subtitle = " "
        }
    }

}











