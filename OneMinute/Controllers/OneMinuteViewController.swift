//
//  OneMinuteViewController.swift
//  OneMinute
//
//  Created by Q on 16/2/25.
//  Copyright © 2016年 zwq. All rights reserved.
//

// uncouple the MVC later on

import UIKit

class OneMinuteViewController: UIViewController {
    
    private var timer: NSTimer?
    private var counter = 1500
    private var immersionCP: KYCircularProgress!
    private var pomodoroCP: KYCircularProgress!
    private var starBadgeCP: KYCircularProgress!
    private var startTime: NSTimeInterval!
    private var isRunning: Bool = false
    
    @IBOutlet weak var starBadge: UIView!
    @IBOutlet weak var oneMinuteCP: KYCircularProgress!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var oneMinuteBtn: UIButton!
    @IBOutlet weak var goalLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.sharedApplication().idleTimerDisabled = true
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
//    
//    func update() {
//        counter--
//        switch counter {
//        case 1440 ... 1500:
//            updateOneMinuteCP()
//            updateStarBadgeCP()
//        case 1439:
//            UIApplication.sharedApplication().idleTimerDisabled = false
//            timeLabel.font = UIFont(name: "HelveticaNeue-UltraLight", size: 60)
//            oneMinuteBtn.hidden = false
//            oneMinuteBtn.setTitleColor(UIColor.redColor(), forState: .Normal)
//            oneMinuteBtn.setTitle("Finish", forState: .Normal)
//            updateImmersionCP()
//        case 600 ... 1438:
//            updateImmersionCP()
//        case 0...599:
//            updataPomodoroCP()
//        default:
//            timeLabel.font = UIFont(name: "HelveticaNeue-UltraLight", size: 35)
//            timer!.invalidate()
//            timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector:"updateTimeLabelWithHours", userInfo: nil, repeats: true)
//            NSRunLoop.mainRunLoop().addTimer(timer!, forMode: NSRunLoopCommonModes)
//        }
//    }
    
    func update() {
        let elapsedTime = UInt(NSDate.timeIntervalSinceReferenceDate() - startTime)
        switch elapsedTime {
        case 0 ... 60:
            updateOneMinuteCP()
            updateStarBadgeCP()
        case 1439:
            UIApplication.sharedApplication().idleTimerDisabled = false
            timeLabel.font = UIFont(name: "HelveticaNeue-UltraLight", size: 60)
            oneMinuteBtn.hidden = false
            oneMinuteBtn.setTitleColor(UIColor.redColor(), forState: .Normal)
            oneMinuteBtn.setTitle("Finish", forState: .Normal)
            updateImmersionCP()
        case 600 ... 1438:
            updateImmersionCP()
        case 0...599:
            updataPomodoroCP()
        default:
            timeLabel.font = UIFont(name: "HelveticaNeue-UltraLight", size: 35)
            timer!.invalidate()
            timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector:"updateTimeLabelWithHours", userInfo: nil, repeats: true)
            NSRunLoop.mainRunLoop().addTimer(timer!, forMode: NSRunLoopCommonModes)
        }
    }
    
    func updateTimeLabelWithHours() {
        let ti: NSTimeInterval = NSDate.timeIntervalSinceReferenceDate() + NSTimeInterval(1500) - startTime
        let hours = Int((ti / 60) / 60)
        let minutes = Int((ti - NSTimeInterval(hours) * 60) / 60)
        let seconds = Int((ti - NSTimeInterval(hours) * 60 - NSTimeInterval(minutes) * 60))
        timeLabel.text = String(format: "%02i : %02i : %02i", hours, minutes, seconds)
//        print(ti, hours, minutes, seconds)
    }
    
    func updateOneMinuteCP() {
        timeLabel.text = "\(counter - 1440)"
        oneMinuteCP.progress = (1.0 - Double(counter - 1440) / 60.0)
    }
    
    func updateImmersionCP() {
        timeLabel.text = String(format: "%02i : %02i", Int(counter / 60 - 10), Int(counter % 60))
        immersionCP.progress = (1.0 - Double(counter - 600) / 900.0)
    }
    
    func updataPomodoroCP() {
        timeLabel.text = String(format: "%02i : %02i", Int(counter / 60), Int(counter % 60))
        pomodoroCP.progress = (1.0 - Double(counter) / 1500.0)
    }
    
    func updateStarBadgeCP() {
        starBadgeCP.progress = (1.0 - Double(counter - 1440) / 60.0)
    }
}


// MARK: Actions
extension OneMinuteViewController {
    
    @IBAction func oneMinuteClicked(sender: AnyObject) {
        
        if !isRunning {
            startTime = NSDate.timeIntervalSinceReferenceDate()
            timer = NSTimer.scheduledTimerWithTimeInterval(0.001, target: self, selector:"update", userInfo: nil, repeats: true)
            NSRunLoop.mainRunLoop().addTimer(timer!, forMode: NSRunLoopCommonModes)
            navigationItem.rightBarButtonItem = nil
            goalLabel.hidden = false
            oneMinuteBtn.hidden = true
            self.isRunning = true
        } else {
            timer!.invalidate()
            timer = nil
            self.isRunning = false
            oneMinuteBtn.setTitle("Dismiss", forState: .Normal)
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
        immersionCP.colors = [UIColor(rgba: 0x53C7A0AA), UIColor(rgba: 0x3891E6AA)]

        
        view.addSubview(immersionCP)
        
    }
    
    func configureStarBadge() {
        
        starBadgeCP = KYCircularProgress(frame: starBadge.bounds)
        starBadgeCP.colors = [UIColor.yellowColor(), UIColor.orangeColor()]
//        starBadgeCP.colors = [UIColor.yellowColor()]
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
