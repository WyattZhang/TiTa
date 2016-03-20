//
//  OneMinuteViewController.swift
//  OneMinute
//
//  Created by Q on 16/2/25.
//  Copyright © 2016年 zwq. All rights reserved.
//

// uncouple the MVC later on


import UIKit

protocol OneMinuteViewControllerDelegate: class {
    func oneMinuteViewController(viewController: OneMinuteViewController, didFinishTiming oneMinute: OneMinute)
}

class OneMinuteViewController: UIViewController {
    
    var timer: NSTimer?
    var counter = 0.0
    var immersionCP: KYCircularProgress!
    var pomodoroCP: KYCircularProgress!
    var starBadgeCP: KYCircularProgress!
    var oneMinute: OneMinute = OneMinute()
    var isRunning: Bool = false
    
    weak var delegate: OneMinuteViewControllerDelegate?
    
    @IBOutlet weak var starBadge: UIView!
    @IBOutlet weak var oneMinuteCP: KYCircularProgress!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var oneMinuteBtn: UIButton!
    @IBOutlet weak var goalLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationController()
        goalLabel.hidden = true
        oneMinuteBtn.layer.borderWidth = 0.5
        oneMinuteBtn.layer.cornerRadius = 5
        oneMinuteBtn.layer.borderColor = UIColor.grayColor().CGColor
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        configureImmersionCP()
        configurePomodoroCP()
        configureStarBadge()
        print(self.presentingViewController)
        }
    
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func configureNavigationController() {
        navigationController!.navigationBar.translucent = false
        navigationController!.navigationBar.barStyle = .Black
//        navigationController!.navigationBar.clipsToBounds = true;
//        let rightBar = UIBarButtonItem(barButtonSystemItem: .Camera, target: self, action: "")
//        self.navigationItem.rightBarButtonItem = rightBar
    }
    
    func update() {
        
        let ti: NSTimeInterval = NSDate.timeIntervalSinceReferenceDate() - oneMinute.startTime
        let elapsedTime = UInt(ti)
        let hours = UInt((ti / 60.0) / 60.0)
        let minutes = UInt((ti - NSTimeInterval(hours) * 60.0 * 60.0) / 60.0)
        let seconds = UInt((ti - NSTimeInterval(hours) * 60.0 * 60.0 - NSTimeInterval(minutes) * 60.0))

        switch elapsedTime {
        case 0 ... 59:
            counter++
            updateOneMinuteCP(minutes,seconds)
            updateStarBadgeCP(seconds)
            print(elapsedTime, timeLabel.text, hours, minutes, seconds)
        case 60:
            counter++
            updateOneMinuteCP(minutes,seconds)
            updateStarBadgeCP(seconds)
            timer!.invalidate()
            timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector:"update", userInfo: nil, repeats: true)
            NSRunLoop.mainRunLoop().addTimer(timer!, forMode: NSRunLoopCommonModes)
            print(elapsedTime, timeLabel.text, hours, minutes, seconds)
        case 61:
            UIApplication.sharedApplication().idleTimerDisabled = false
            timeLabel.font = UIFont(name: "HelveticaNeue-UltraLight", size: 60)
            oneMinuteBtn.hidden = false
            oneMinuteBtn.setTitleColor(UIColor.redColor(), forState: .Normal)
            oneMinuteBtn.setTitle("Finish", forState: .Normal)
            updateImmersionCP(elapsedTime, minutes, seconds)
            print(elapsedTime, timeLabel.text, hours, minutes, seconds)
        case 62 ... 900:
            updateImmersionCP(elapsedTime, minutes, seconds)
            print(elapsedTime, timeLabel.text, hours, minutes, seconds)
        case 901...1500:
            updataPomodoroCP(elapsedTime, minutes, seconds)
            print(elapsedTime, timeLabel.text, hours, minutes, seconds)
        case 1501:
            timeLabel.font = UIFont(name: "HelveticaNeue-UltraLight", size: 35)
            updateTimeLabelWithHours(hours, minutes, seconds)
            print(elapsedTime, timeLabel.text, hours, minutes, seconds)
        default:
            updateTimeLabelWithHours(hours, minutes, seconds)
            print(elapsedTime, timeLabel.text, hours, minutes, seconds)
        }
    }
    
    func updateOneMinuteCP(minutes: UInt, _ seconds: UInt) {
        if minutes == 1 {
            timeLabel.text = "0"
        } else {
            timeLabel.text = "\(60 - seconds)"
        }
        oneMinuteCP.progress = (counter / 600.0)
    }
    
    func updateStarBadgeCP(seconds: UInt) {
        starBadgeCP.progress = (counter / 600.0)
    }
    
    func updateImmersionCP(elapsedTime: UInt, var _ minutes: UInt, var _ seconds: UInt) {
        
        if seconds == 0 {
            seconds = 60
            minutes--
        }
        
        if minutes > 14 {
            minutes = 14
        }

        
        timeLabel.text = String(format: "%02i : %02i", 14 - minutes, 60 - seconds)
        immersionCP.progress = (Double(elapsedTime) / 900.0)
    }
    
    func updataPomodoroCP(elapsedTime: UInt, var _ minutes: UInt, var _ seconds: UInt) {
        
        if seconds == 0 {
            seconds = 60
            minutes--
        }
        
        if minutes > 24 {
            minutes = 24
        }
        
        timeLabel.text = String(format: "%02i : %02i", 24 - minutes, 60 - seconds)
        pomodoroCP.progress = (Double(elapsedTime) / 1500.0)
    }
    
    func updateTimeLabelWithHours(hours: UInt, _ minutes: UInt, _ seconds: UInt) {
        timeLabel.text = String(format: "%i : %02i : %02i", hours, minutes, seconds)
    }
    
}


// MARK: Actions
extension OneMinuteViewController {
    
    @IBAction func oneMinuteClicked(sender: AnyObject) {
        
        if !isRunning && oneMinuteBtn.titleLabel!.text != "Dismiss" {
            UIApplication.sharedApplication().idleTimerDisabled = true
            oneMinute.startTime = NSDate.timeIntervalSinceReferenceDate()
            timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector:"update", userInfo: nil, repeats: true)
            NSRunLoop.mainRunLoop().addTimer(timer!, forMode: NSRunLoopCommonModes)
            navigationItem.rightBarButtonItem = nil
            goalLabel.hidden = false
            oneMinuteBtn.hidden = true
            self.isRunning = true
        } else if timer != nil {
            timer!.invalidate()
            timer = nil
            self.isRunning = false
            oneMinute.finishTime = NSDate.timeIntervalSinceReferenceDate()
            oneMinuteBtn.setTitle("Dismiss", forState: .Normal)
        } else {
            self.delegate!.oneMinuteViewController(self, didFinishTiming: oneMinute)
            self.navigationController!.popToRootViewControllerAnimated(true)
        }
    }
        
}

// MARK: Move to OneMinuteView and uncouple later
extension OneMinuteViewController {
    
    func configurePomodoroCP() {
        let pomodoroCPFrame = CGRectMake(oneMinuteCP.frame.origin.x + 20.0,oneMinuteCP.frame.origin.y + 20.0, oneMinuteCP.bounds.width - 40.0, oneMinuteCP.bounds.height - 40.0)
        pomodoroCP = KYCircularProgress(frame: pomodoroCPFrame)
        pomodoroCP.colors = [UIColor(rgba: 0xDE342EAA), UIColor(rgba: 0xFFF77A55), UIColor.grayColor()]

        view.addSubview(pomodoroCP)
        
    }
    
    func configureImmersionCP() {
        
        let immersionCPFrame = CGRectMake(oneMinuteCP.frame.origin.x + 10.0,oneMinuteCP.frame.origin.y + 10.0, oneMinuteCP.bounds.width - 20.0, oneMinuteCP.bounds.height - 20.0)
        immersionCP = KYCircularProgress(frame: immersionCPFrame)
//        immersionCP.colors = [UIColor(rgba: 0xA6E39DAA), UIColor(rgba: 0xAEC1E3AA), UIColor(rgba: 0xAEC1E3AA), UIColor(rgba: 0xF3C0ABAA)]
        immersionCP.colors = [UIColor(rgba: 0x3891E6AA), UIColor(rgba: 0x53C7A0AA)]

        
        view.addSubview(immersionCP)
        
    }
    
    func configureStarBadge() {
        
        starBadgeCP = KYCircularProgress(frame: starBadge.bounds)
        starBadgeCP.colors = [UIColor.yellowColor(), UIColor.orangeColor()]
        starBadgeCP.lineWidth = 0.5
        
        starBadgeCP.path = starPathInRect(starBadge.bounds)
        starBadge.addSubview(starBadgeCP)
    }
    
    func pointFrom(angle: CGFloat, radius: CGFloat, offset: CGPoint) -> CGPoint {
        return CGPointMake(radius * cos(angle) + offset.x, radius * sin(angle) + offset.y)
    }
    
    func starPathInRect(rect: CGRect) -> UIBezierPath {
        let path = UIBezierPath()
        
        let starExtrusion:CGFloat = 4.0
        
        let center = CGPointMake(rect.width / 2.0, rect.height / 2.0)
        
        let pointsOnStar = 5
        
        var angle:CGFloat = -CGFloat(M_PI / 2.0)
        let angleIncrement = CGFloat(M_PI * 2.0 / Double(pointsOnStar))
        let radius = rect.width / 2.0
        
        var firstPoint = true
        
        for _ in 1...pointsOnStar {
            
            let point = pointFrom(angle, radius: radius, offset: center)
            let nextPoint = pointFrom(angle + angleIncrement, radius: radius, offset: center)
            let midPoint = pointFrom(angle + angleIncrement / 2.0, radius: starExtrusion, offset: center)
            
            if firstPoint {
                firstPoint = false
                path.moveToPoint(point)
            }
            
            path.addLineToPoint(midPoint)
            path.addLineToPoint(nextPoint)
            
            angle += angleIncrement
        }
        
        path.closePath()
        
        return path
    }
}
